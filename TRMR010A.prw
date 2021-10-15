#include "rwmake.ch"
#include "report.ch"
#INCLUDE "topconn.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#Include "AP5Mail.ch"

/*
--------------------------------------------------------------------------------------------------------------------------------------
Programa  TRMR010A   Autor  FERNANDO AMORIM       Data  30/06/16 
Descricao Impressao de relatorio de cargos
TABELA DE CARGOS                      - SQ3
TABELA DE GRADUAÇÃO DE CARGOS         - SQ4
TABELA DE FATORES GERAIS DE AVALIAÇÃO - SQV
--------------------------------------------------------------------------------------------------------------------------------------
Uso       RDMAKE  
--------------------------------------------------------------------------------------------------------------------------------------
*/

//------------------------------------------------------------------------------------------------------------------------------------
User Function TRMR010A()
local ACARGO   := {}
local Q4_FATOR := ''                                                            
local Q4_GRAU  := ''  
_CAMINHO       := GetTempPath()

Pergunte("TR010R",.T.)
//-------------------------------------------------------------------------------------------
// Perguntas Padrão
// mv_par01 = FILIAL                             										C  2
// mv_par02 = CARGO                              										C  2
// mv_par03 = GRUPO                              										C  2
// mv_par04 = IMP DESCR DETALHADA                										N  1
// mv_par05 = IMP RESPONS. DO CARGO              										N  1
// mv_par06 = IMP RELACION. DO CARGO             										N  1
// mv_par07 = IMP HABILIADES DO CARGO            										N  1
// mv_par08 = IMP GRADUAÇÃO                      										N  1
// mv_par09 = FATOR GRADUAÇÃO                    										C  2
// mv_par10 = IMP GRADUCAÇO DETALHADA            										N  1
// mv_par11 = IMPRIME PONTOS                     										N  1
// mv_par12 = SOMENTE TOTAIS PONTOS              										N  1  
// mv_par13 = IMPRIME CURSOS                     										N  1 
// mv_par14 = IMPRIME COMPETENCIA/HABILIDADES    										N  1
// mv_par15 = IMPRIME CARGO POR FOLHA            										N  1
//-------------------------------------------------------------------------------------------


DBSELECTAREA("SQ3")                                                                
DbSetOrder(1)                                                                         //FILIAL+CARGO+CC
IF dbSeek( xFilial("SQ3")+MV_PAR02)       
	WHILE !EOF() .AND. ALLTRIM(Q3_FILIAL) = ALLTRIM(MV_PAR01) .AND. ALLTRIM(Q3_CARGO) >= ALLTRIM(MV_PAR02)
		DBSELECTAREA('SQ4')                                                           //POSICIONO TABELA DE GRADUAÇÃO DE CARGOS
		DBSETORDER(1)                                                                 //FILIAL + CARGO + FATOR
		IF DBSEEK(xFilial("SQ4")+ALLTRIM(SQ3->Q3_CARGO)+MV_PAR09)
			_FATOR := Q4_FATOR
			_GRAU  := Q4_GRAU 		

			DbSelectArea("SQ3")
			AADD(ACARGO ,{Q3_FILIAL,;                                                 //1  //ADICIONO NO ARRAY DE CARGOS 
				Q3_CARGO,;                                                            //2
				Q3_DESCSUM,;                                                          //3
				Q3_DEPTO,;                                                            //4
				Q3_DRESP,;                                                            //5
				posicione("SQV",1,XFILIAL("SQV")+_FATOR+_GRAU,'QV_GRAU'),;            //6  //filial + fator + grau
				posicione("SQV",1,XFILIAL("SQV")+_FATOR+_GRAU,'QV_DESCGRA'),;         //7
				posicione("SQV",1,XFILIAL("SQV")+_FATOR+_GRAU,'QV_DESCFAT'),;         //8
				_FATOR,;                                                              //9
				_GRAU,;                                                               //10
				'Experiência de até 1 ano como Ajudante Geral',;                      //11
				Q3_DHABILI,;                                                          //12
				Q3_DESCDET,;                                                          //13
				Q3_MEMO6,;                                                            //14
				Q3_MEMO7,;                                                            //15
				Q3_MEMO8,;                                                            //16
				Q3_MEMO9})                                                            //17
		ELSE
			ALERT('GRADUAÇÃO NÃO ENCONTRADA PARA O CARGO, VERIFIQUE...')
		ENDIF
		dbskip()
	enddo
	//chama funcao de impressao
	gercgpdf(ACARGO)
	//LIMPO ARRAY DE CARGOS
	ACARGO := {}
else
	msgbox('Cargo nao encontrado, escolha um cargo valido, utilize a tecla f3 para os parametros')
endif
Return

//-------------------------------------------------------------------------------------------------------------------
//gera impressao
static Function gercgpdf(ACARGO)
LOCAL INC     := 0
LOCAL INC1    := 0
NROW          := 0
NCOL          := 0


//FORMATA FONTES
oFont1 := TFont():New( "Courier New"    , , -18, .T.)   
oFont2 := TFont():New( "Times New Roman", ,  20, .T.) 
oFont3 := TFont():New( "Times New Roman", ,  10, .T.)
oFont4 := TFont():New( "Courier New"    , ,   8, .T.)      
oFont5 := TFont():New( "Courier New"    , ,  10, .T.,.T.)  //NEGRITO
oFont6 := TFont():New( "Courier New"    , ,   8, .T.,.T.)  //NEGRITO
oFont7 := TFont():New( "Courier New"    , ,   9, .T.,.T.)  //NEGRITO
oFont8 := TFont():New( "Times New Roman", ,  10, .T.)
oFont9 := TFont():New( "Courier New"    , ,  12, .T.,.T.)  //NEGRITO

IF LEN(ACARGO) > 0  // SE ACHOU ITENS A IMPRIMIR
	_NPAG := 1
	//inicia variavel de controle
	_control := ALLTRIM(ACARGO[1][2])  //codigo do cargo

	//inicia objeto printer da primeira nota do array
	oPrinter:= FWMSPrinter():New(_control,IMP_PDF,.F.,alltrim(_CAMINHO),.T.)
	oPrinter:setPortrait()  //Retrato
	oPrinter:SetPaperSize(DMPAPER_A4)
	oPrinter:SetMargin(60,60,60,60)
	oPrinter:cPathPDF := alltrim(_CAMINHO)
    oPrinter:StartPage()

    //IMPRIMO PRIMEIRO CABECALHO
    cabec()		
	
	//loop do array IMPRIME LINHAS DE PRODUTOS
	for INC:= 1 to len(ACARGO)        
	    IF _CONTROL <> ALLTRIM(ACARGO[INC][2])          //SE CARGO DIFERENTE
	    	RODAPE()
	    	_CONTROL := ALLTRIM(ACARGO[INC][2])
	    	oPrinter:EndPage()
	    	NROW   := 0
	    	IF INC <= len(ACARGO)      //SE AINDA TEM ITENS A IMPRIMIR
	    		_NPAG := 1
	    		oPrinter:StartPage() //NOVA PAGINA
		    	cabec() //CABECALHO 
		    	CORPO() //CORPO - IMPRIME LINHA DO PRODUTO
		    	IF INC = len(ACARGO)
		    		RODAPE()
		    	ENDIF
	    	ENDIF 	
	    ELSE
	    	CORPO() //CORPO - IMPRIME LINHA DO PRODUTO                    

			IF INC = len(ACARGO) //SE ULTIMO

			    IF _NPAG = 1
		    		RODAPE()
		    	ENDIF	
		    	oPrinter:EndPage()
			ENDIF

			IF _NPAG = 1
				IF NROW > 400 .AND. INC < LEn(ACARGO)    // AJUSTAR NO LAYOUT - CAPACIDADE DE ITENS POR PAGINAS, PAGINA 1
					oPrinter:Say( nRow, nCol + 400,  "CONTINUA NA PROXIMA PAGINA....... "  , oFont4, 1400, CLR_BLACK)
	    			nRow := nRow +10				
   					RODAPE()
					oPrinter:EndPage()
					oPrinter:StartPage() //NOVA PAGINA
					_NPAG := _NPAG + 1
					nrow = 10
			    	cabec() //CABECALHO 
				ENDIF
			ELSE
				IF NROW > 600 .AND. INC < LEn(ACARGO) // AJUSTAR NO LAYOUT - CAPACIDADE DE ITENS POR PAGINAS A PARTIR DA PAGINA 2
					oPrinter:Say( nRow, nCol + 400,  "CONTINUA NA PROXIMA PAGINA....... "  , oFont4, 1400, CLR_BLACK)
	    			nRow := nRow +10				
					oPrinter:EndPage()
					oPrinter:StartPage() //NOVA PAGINA
					_NPAG := _NPAG + 1
					nrow = 10
			    	cabec() //CABECALHO 
				ENDIF
			ENDIF
        ENDIF
	next
		
	//ENCERRA OBJETO DE IMPRESSAO 
	oPrinter:EndPage()

	oPrinter:SetDevice(IMP_PDF) //USADO PARA VISUALIZAR O PREVIEW DO FWMSPRINTER QUE  VIA VISUALIZADOR PDF PADRAO DA MAQUINA

	//imprimir
	oPrinter:Print() 
	
	FreeObj(oPrinter)
	oPrinter := Nil 
	Ms_Flush()
	
	//repassa o primeiro
	_CONTROLE := ACARGO[1][2]
	REPAREV(ACARGO[1][2])
	for INC1:= 1 to len(ACARGO)
		IF _CONTROLE <> ACARGO[INC1][2]
			REPAREV(ACARGO[INC1][2])
			_CONTROLE := ACARGO[INC1][2]
		endif	
	NEXT	

ENDIF 
return


//funcoes auxiliares ------------------------------------------------------------------------------------------------------
static function cabec()
	local _lglarg  := 0
	local _lgaltu  := 0
	local _incolti := 0
	local _incolpg := 0
	local _incollg := 0
	local _incolqd := 0
	local _ficolqd := 0

	//TRATA MOEDA
	TRMOEDA(_cMoeda)

	//ADQUIRO DADOS DA SM0 SEM ACESSAR A TABELA POIS NO DICIONARIO NA BASE So PELA CLASSE FWSM0Util - GERA ARRAYS COM OS DADOS
	aSM0Data2 := FWSM0Util():GetSM0Data() //Retorna todos os campos da SM0 do grupo e filial logados no sistema

	//ajusta inicio
	nRow := nRow + 40

    //IMPRIME LOGOTIPO--------------------------------------------------------------------------
	_lglarg  := 280
	_lgaltu  := 80
	_incollg := 0
	_lglarg  := 192
	_lgaltu  := 64
	_incollg := 0

	DO CASE
	CASE aSM0Data2[1][2] = "01"
		IF File("logo-novo.png")  //TRATA LOGOTIPO empresa 01 -ESPECIFICO
			oPrinter:SayBitmap( nRow,nCol + _incollg, "logo-novo.png", _lglarg, _lgaltu)
		ELSEIF File("lgrl01.bmp")  //TRATA LOGOTIPO empresa 0101
			oPrinter:SayBitmap( nRow,nCol + _incollg, "lgrl0101.bmp", _lglarg, _lgaltu)		
		ELSEIF File("lgrl0101.bmp")  //TRATA LOGOTIPO empresa 0101
			oPrinter:SayBitmap( nRow,nCol + _incollg, "lgrl0101.bmp", _lglarg, _lgaltu)		
		ENDIF
	CASE aSM0Data2[1][2] = "02"
		IF File("logo-novo.png")  //TRATA LOGOTIPO empresa 02 -ESPECIFICO
			oPrinter:SayBitmap( nRow,nCol + _incollg, "logo-novo.png", _lglarg, _lgaltu)
		ELSEIF File("lgrl02.bmp")  //TRATA LOGOTIPO empresa 02
			oPrinter:SayBitmap( nRow,nCol + _incollg, "lgrl02.bmp", _lglarg, _lgaltu)
		ELSEIF File("lgrl0102.bmp")  //TRATA LOGOTIPO empresa 0102
			oPrinter:SayBitmap( nRow,nCol + _incollg, "lgrl0102.bmp", _lglarg, _lgaltu)				
		ENDIF
	CASE aSM0Data2[1][2] = "03"
		IF File("logo-novo.png")  //TRATA LOGOTIPO empresa 03 -ESPECIFICO
			oPrinter:SayBitmap( nRow,nCol + _incollg, "logo-novo.png", _lglarg, _lgaltu)	
		ELSEIF File("lgrl03.bmp")  //TRATA LOGOTIPO empresa 03
			oPrinter:SayBitmap( nRow,nCol + _incollg, "lgrl03.bmp", _lglarg, _lgaltu)
		ELSEIF File("lgrl0103.bmp")  //TRATA LOGOTIPO empresa 0103
			oPrinter:SayBitmap( nRow,nCol + _incollg, "lgrl0103.bmp", _lglarg, _lgaltu)				
		ENDIF
	CASE aSM0Data2[1][2] = "04"
		IF File("logo-novo.png")  //TRATA LOGOTIPO empresa 04-ESPECIFICO
			oPrinter:SayBitmap( nRow,nCol + _incollg, "logo-novo.png", _lglarg, _lgaltu)	
		ELSEIF File("lgrl04.bmp")  //TRATA LOGOTIPO empresa 04
			oPrinter:SayBitmap( nRow,nCol + _incollg, "lgrl04.bmp", _lglarg, _lgaltu)
		ELSEIF File("lgrl0104.bmp")  //TRATA LOGOTIPO empresa 0104
			oPrinter:SayBitmap( nRow,nCol + _incollg, "lgrl0104.bmp", _lglarg, _lgaltu)				
		ENDIF
	CASE aSM0Data2[1][2] = "05"
		IF File("logo-novo.png")  //TRATA LOGOTIPO empresa 05 -ESPECIFICO
			oPrinter:SayBitmap( nRow,nCol + _incollg, "logo-novo.png", _lglarg, _lgaltu)	
		ELSEIF File("lgrl05.bmp")  //TRATA LOGOTIPO empresa 05
			oPrinter:SayBitmap( nRow,nCol + _incollg, "lgrl05.bmp", _lglarg, _lgaltu)
		ELSEIF File("lgrl0105.bmp")  //TRATA LOGOTIPO empresa 0105
			oPrinter:SayBitmap( nRow,nCol + _incollg, "lgrl0105.bmp", _lglarg, _lgaltu)				
		ENDIF
	OTHERWISE
		IF File("logo-novo.png")  //TRATA LOGOTIPO empresa 99 -ESPECIFICO
			oPrinter:SayBitmap( nRow,nCol + _incollg, "logo-novo.png", _lglarg, _lgaltu)	
		ELSEIF File("lgrl99.bmp")  //TRATA LOGOTIPO empresa 99 - TESTE
			oPrinter:SayBitmap( nRow,nCol + _incollg, "lgrl99.bmp", _lglarg, _lgaltu)
		ENDIF
		IF File("lgrl0199.bmp")  //TRATA LOGOTIPO empresa 0199 - TESTE
			oPrinter:SayBitmap( nRow,nCol + _incollg, "lgrl0199.bmp", _lglarg, _lgaltu)
		ENDIF
	ENDCASE
	//-------------------------------------------------------------------------------------------

    //IMPRIME DADOS EMPRESA NO CABECALHO 
	_incolti := 250
    nRow := nRow + 20
    oPrinter:Say( nRow, nCol + _incolti, aSM0Data2[5][2], oFont2, 1400,)                                                            //NOME COMERCIAL
    nRow := nRow + 10
    oPrinter:Say( nRow, nCol + _incolti, aSM0Data2[6][2], oFont5, 1400, CLR_BLACK)                                                  //ENDEREï¿½O
	nRow := nRow + 10	
	oPrinter:say(nRow,nCol + _incolti,ALLTRIM(aSM0Data2[7][2]) + '-' + aSM0Data2[8][2],oFont5,100)                                  //MUNICIPIO + UF
	nRow := nRow + 10
	oPrinter:say(nRow,nCol + _incolti,'cep: ' +aSM0Data2[9][2] ,oFont5,100)                                                         //CEP
    nRow := nRow + 10
	if empty(aSM0Data2[20][2])
    	oPrinter:Say( nRow, nCol + _incolti, "Tel: "  + aSM0Data2[16][2], oFont5, 1400, CLR_BLACK)                                  //TEL
	else
    	oPrinter:Say( nRow, nCol + _incolti, "Tel: "  + aSM0Data2[16][2]  +  "Fax: " + aSM0Data2[20][2] , oFont5, 1400, CLR_BLACK)  //TEL FAX
	endif	
    nRow := nRow +10
    oPrinter:Say( nRow, nCol + _incolti, "CNPJ: " + transform(aSM0Data2[14][2], "@R 99.999.999/9999-99") +  "  IE: " + transform(aSM0Data2[15][2], "@R 999.999.999-99"), oFont5, 1400, CLR_BLACK)   //CNPJ IE 
    nRow := nRow +10
    oPrinter:Say( nRow, nCol + _incolti, "e-mail: sintequimica@sintequimica.com.br", oFont5, 1400, CLR_BLACK)                               //email

    nRow := nRow +10
 
    //IMPRIME QUADROS
	_incolqd := 0
	_ficolqd := 810
    //oPrinter:Box( AI, LI, AF, LF, "-4")  "-4")
    oPrinter:Box(nRow, nCol+_incolqd, nRow+30, nCol+_ficolqd, "-4") //quadro superior externo
    oPrinter:Box(nRow, nCol+690, nRow+30, nCol+_ficolqd, "-4")      //quadro superior interno
    oPrinter:Box(nRow, nCol+_incolqd, nRow+95, nCol+_ficolqd, "-4") //quadro inferior externo
    oPrinter:Box(nRow, nCol+690, nRow+95, nCol+_ficolqd, "-4")	    //quadro inferior interno

    //imprime descricao relatorio
    nRow := nRow +20
 	oPrinter:Say( nRow    , nCol + 15,  "DAG - DADOS GERAIS", oFont1, 1400, CLR_BLACK) 
    oPrinter:Say( nRow    , nCol + 370, "Emissao: " + alltrim(DTOC(_dEmissao)) , oFont1, 1400, CLR_BLACK) 
	oPrinter:Say( nRow -10, nCol + 710, "Data de Impressao:    " , oFont4, 1400, CLR_BLACK)
	oPrinter:Say( nRow    , nCol + 710, alltrim(DTOC(DDATABASE)) + "-" + TIME() , oFont4, 1400, CLR_BLACK)
    nRow := nRow +20
	oPrinter:Say( nRow    , nCol + 410, 'Process/Titulo' , oFont4, 1400, CLR_BLACK)
	oPrinter:Say( nRow    , nCol + 610, 'Identificação' , oFont4, 1400, CLR_BLACK)	
	oPrinter:Say( nRow    , nCol + 650, 'Revisão' , oFont4, 1400, CLR_BLACK)

    nRow := nRow +7
	//numero pagina
	_incolpg := 710
    oPrinter:Say( nRow, nCol + _incolpg,  "Pagina nº " + alltrim(STR(_NPAG)), oFont5, 1400, CLR_BLACK) 

	oPrinter:Say( nRow +20, nCol + 410, 'Descrição de cargos' , oFont4, 1400, CLR_BLACK)
    nRow := nRow +10

return
//-------------------------------------------------------------------------------------------------------------------------
STATIC FUNCTION CORPO()

    oPrinter:Say( nRow, nCol + 010,  alltrim('---')                                           , oFont5, 1400, CLR_BLACK)      //item
   
    nRow := nRow +12  
  
RETURN()

//-------------------------------------------------------------------------------------------------------------------------
STATIC FUNCTION RODAPE()
	
    //IMPRIME QUADRO ENTREGA
    oPrinter:Box(nRow, nCol, nRow+25, nCol+810, "-4")
	nRow := nRow +10
	if _endeen = 1  //se enderï¿½o fisico
		oPrinter:Say(nRow, nCol + 05, "LOCAL DE ENTREGA\COBRANï¿½A:" + 'Rua Josï¿½ Lopes, 360 - Parque Industrial Araucï¿½ria - Laranjeiras - Caieiras- SP cep:07747-150' , oFont5, 1400, CLR_BLACK)  
	else
		oPrinter:Say(nRow, nCol + 05, "LOCAL DE ENTREGA\COBRANï¿½A:" + 'Caixa postal 46819 cep 05206-970' , oFont5, 1400, CLR_BLACK)  
	endif
	nRow := nRow +10                                                                                  
	nRow := nRow +5

	//imprime quadro anotacoes
    oPrinter:Box(nRow,   nCol, nRow+25, nCol+810, "-4")
	nRow := nRow +20

    //imprime quadro informcoes importantes
	nRow := nRow +45
	oPrinter:Say( nRow, nCol + 15, "INFORMACOES IMPORTANTES:"     , oFont4, 1400, CLR_BLACK)  
	nRow := nRow +10                                                                                  
	oPrinter:Say( nRow, nCol + 15, "As orientações aqui contidas não egotam o assunto sobre prevenção de acidentes  devendo ser observada todas as" , oFont8, 1400, CLR_BLACK)  
	nRow := nRow +10
	oPrinter:Say( nRow, nCol + 15, "instruções existentes ainda que verbais em especial as Normas e Regulamentos da Empresa."    , oFont8, 1400, CLR_BLACK)  
	nRow := nRow +10
	oPrinter:Say( nRow, nCol + 15, "Não executar qualquer atividade sem trinamento e pleno conhecimento dos riscos e cuidados a serem observados."   , oFont8, 1400, CLR_BLACK)
	nRow := nRow +20
	oPrinter:Say( nRow, nCol + 15, "Declaro ter recebido as instruções acima descritas e comprometo-me a cumprí-las,  "   , oFont8, 1400, CLR_BLACK)
	nRow := nRow +20
	oPrinter:Say( nRow, nCol + 15, "Nome: _______________________________________________________________"   , oFont9, 1400, CLR_BLACK)
	nRow := nRow +20
	oPrinter:Say( nRow, nCol + 15, "Assinatura: _________________________________________________________                                Data:___/___/_______"   , oFont9, 1400, CLR_BLACK)	

RETURN
