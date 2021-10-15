#INCLUDE "PROTHEUS.CH"
#INCLUDE "TRMR010.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TRMR010  ³ Autor ³ Eduardo Ju            ³ Data ³ 20/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Cargos do Treinamento                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TRMR010                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cecilia Car.³31/07/14³TPZWAO³AIncluido o fonte da 11 para a 12 e efetua³±±
±±³            ³        ³      ³da a limpeza.                             ³±±
±±³Henrique V. ³08/01/15³TRHHXE³Réplica chamado TRHHXE-Ajuste referente a ³±±
±±³            ³        ³      ³Ordem de tratamento da tabela RA5, agora  ³±±
±±³            ³        ³      ³levando em conta Centro de Custo do Cargo ³±±
±±³            ³        ³      ³a ser impresso                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Function TRMR010()
Local oReport
Local aArea := GetArea()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TR010R",.F.)
oReport := ReportDef()
oReport:PrintDialog()

RestArea( aArea )

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef() ³ Autor ³ Eduardo Ju          ³ Data ³ 20.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Definicao do Componente de Impressao do Relatorio           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local oSection1	
Local oSection2         
Local oSection3
Local oSection4
Local oSection5
Local oSection6
Local oSection7
Local oSection8

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:=TReport():New("TRMR010",STR0001,"TR010R",{|oReport| PrintReport(oReport)},STR0007)	//"Relatorio de Cargos"#"Será impresso de acordo com os parametros solicitados pelo usuario"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Primeira Secao: Cargo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
oSection1 := TRSection():New(oReport,STR0001,{"SQ3","SQ0","SQB","CTT"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)	
oSection1:SetTotalInLine(.F.)      

TRCell():New(oSection1,"Q3_CARGO","SQ3",,,10,.T.)				//Cargo
TRCell():New(oSection1,"Q3_DESCSUM","SQ3","")			//Descricao do Cargo  
TRCell():New(oSection1,"Q3_GRUPO","SQ3",,,10,.T.)				//Grupo
TRCell():New(oSection1,"Q0_DESCRIC","SQ0","")			//Descricao do Grupo
TRCell():New(oSection1,"Q3_DEPTO","SQ3",STR0031)		//Codigo do Depto 
TRCell():New(oSection1,"QB_DESCRIC","SQB","")			//Descricao do Depto 
TRCell():New(oSection1,"Q3_CC","SQ3",,,20,.T.)					//Centro de Custo
TRCell():New(oSection1,"CTT_DESC01","CTT","") 			//Descricao do CC

TRPosition():New(oSection1,"SQ0",1,{|| RhFilial("SQ0",SQ3->Q3_FILIAL) + SQ3->Q3_GRUPO})
TRPosition():New(oSection1,"SQB",1,{|| RhFilial("SQB",SQ3->Q3_FILIAL) + SQ3->Q3_DEPTO})
TRPosition():New(oSection1,"CTT",1,{|| RhFilial("CTT",SQ3->Q3_FILIAL) + SQ3->Q3_CC})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Segunda Secao: Descricao Detalhada do Cargo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1,STR0009,{"SQ3"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)	
oSection2:SetTotalInLine(.F.)  
oSection2:SetHeaderBreak()
oSection2:ShowHeader(.T.) 	//Imprime Cabecalho da Secao
oSection2:SetLeftMargin(2)	//Identacao da Secao    
    
TRCell():New(oSection2,"Q3_DESCDET","SQ3")		//Codigo da Descricao Detalhada do Cargo #SUPRIMIR 
TRCell():New(oSection2,"Q3_MEMO1","SQ3","",/*Picture*/,,/*lPixel*/,{|| MSMM(SQ3->Q3_DESCDET,,,,3)}) //Descricao Detalhada do Cargo
oSection2:Cell("Q3_MEMO1"):SetLineBreak(.T.)//Imprime Campo Memmo  
oSection2:Cell("Q3_DESCDET"):Disable()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Terceira Secao: Descricao das Responsabilidades do Cargo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection3 := TRSection():New(oSection1,STR0021,{"SQ3"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)	
oSection3:SetTotalInLine(.F.)  
oSection3:SetHeaderBreak()
oSection3:ShowHeader(.T.) 	//Imprime Cabecalho da Secao
oSection3:SetLeftMargin(2)	//Identacao da Secao   

TRCell():New(oSection3,"Q3_DRESP","SQ3")			//Codigo da Responsabilidade do Cargo #SUPRIMIR 		
TRCell():New(oSection3,"Q3_MEMO2","SQ3","",/*Picture*/,,/*lPixel*/,{|| MSMM(SQ3->Q3_DRESP,,,,3)}) //Descricao Responsabilidade do Cargo  		

oSection3:Cell("Q3_MEMO2"):SetLineBreak(.T.) //Imprime Campo Memmo
oSection3:Cell("Q3_DRESP"):Disable() 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Quarta Secao: Descricao Relacionamento Interno do Cargo  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection4 := TRSection():New(oSection1,STR0023,{"SQ3"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)	
oSection4:SetTotalInLine(.F.)  
oSection4:SetHeaderBreak()
oSection4:ShowHeader(.T.) 	//Imprime Cabecalho da Secao
oSection4:SetLeftMargin(2)	//Identacao da Secao 
                
TRCell():New(oSection4,"Q3_DRELINT","SQ3")			//Codigo do Relacionamento do Cargo #SUPRIMIR 
TRCell():New(oSection4,"Q3_MEMO3","SQ3","",/*Picture*/,,/*lPixel*/,{|| MSMM(SQ3->Q3_DRELINT,,,,3)}) //Descricao Relacionamento do Cargo

oSection4:Cell("Q3_MEMO3"):SetLineBreak(.T.) //Imprime Campo Memmo
oSection4:Cell("Q3_DRELINT"):Disable() 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Quinta Secao: Descricao das Habilidades do Cargo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection5 := TRSection():New(oSection1,STR0025,{"SQ3"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)	
oSection5:SetTotalInLine(.F.)  
oSection5:SetHeaderBreak()
oSection5:ShowHeader(.T.) 	//Imprime Cabecalho da Secao
oSection5:SetLeftMargin(2)	//Identacao da Secao  
                               
TRCell():New(oSection5,"Q3_DHABILI","SQ3")			//Codigo das Habilidades do Cargo #SUPRIMIR 
TRCell():New(oSection5,"Q3_MEMO4","SQ3","",/*Picture*/,,/*lPixel*/,{|| MSMM(SQ3->Q3_DHABILI,,,,3)}) //Descricao Relacionamento do Cargo
oSection5:Cell("Q3_MEMO4"):SetLineBreak(.T.) //Imprime Campo Memmo
oSection5:Cell("Q3_DHABILI"):Disable() 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Sexta Secao: Graduacao dos Cargos ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection6 := TRSection():New(oSection1,STR0011,{"SQ4","SQ1","SQ2"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)	
oSection6:SetTotalInLine(.F.)  
oSection6:SetHeaderBreak()
oSection6:ShowHeader(.T.) 	//Imprime Cabecalho da Secao
oSection6:SetLeftMargin(2)	//Identacao da Secao  
                              
TRCell():New(oSection6,"Q4_FATOR","SQ4",,,10,.T.)		//Codigo do Fator
TRCell():New(oSection6,"Q1_DESCSUM","SQ1","")	   		//Descricao do Fator 
TRCell():New(oSection6,"Q4_GRAU","SQ4",,,10,.T.)		//Codigo do Grau
TRCell():New(oSection6,"Q2_DESC","SQ2","")				//Descricao do Grau
TRCell():New(oSection6,"Q4_PONTOS","SQ4",,"@E 9999.99",15,.T.)//Pontos   

TRPosition():New(oSection6,"SQ1",3,{|| RhFilial("SQ1",SQ4->Q4_FILIAL) + SQ4->Q4_FATOR})
TRPosition():New(oSection6,"SQ2",2,{|| RhFilial("SQ2",SQ4->Q4_FILIAL) + SQ4->Q4_FATOR + SQ4->Q4_GRAU})	

If MV_PAR12 == 1 
	oSection6:SetTotalText({|| STR0032 })  //"Total de Pontos"
	TRFunction():New(oSection6:Cell("Q4_PONTOS"),/*cId*/,"SUM",/*oBreak*/,/*cTitle*/,"@E 9999.99"/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)
EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Setima Secao: Cursos dos Cargos ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection7 := TRSection():New(oSection1,STR0015,{"RA5","RA1"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)	
oSection7:SetTotalInLine(.F.)  
oSection7:SetHeaderBreak()
oSection7:ShowHeader(.T.) 	//Imprime Cabecalho da Secao
oSection7:SetLeftMargin(2)	//Identacao da Secao  

TRCell():New(oSection7,"RA5_CURSO","RA5",STR0033)	//Codigo do Curso  
TRCell():New(oSection7,"RA1_DESC","RA1","")		//Descricao do Curso 
TRCell():New(oSection7,"RA5_VALIDA","RA5")			//Validade
TRCell():New(oSection7,"RA5_HORAS","RA5")			//Horas Minima
TRCell():New(oSection7,"RA5_NOTA","RA5")			//Nota Minima 
TRCell():New(oSection7,"RA5_FREQUE","RA5")			//% Frequencia Minima  
TRCell():New(oSection7,"RA5_PRIORI","RA5")			//Prioridade
TRCell():New(oSection7,"RA5_UNPRIO","RA5")			//Unidade da Prioridade

TRPosition():New(oSection7,"RA1",1,{|| RhFilial("RA1",RA5->RA5_FILIAL) + RA5->RA5_CURSO }) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Oitava Secao: Competencias/Habilidades ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection8 := TRSection():New(oSection1,STR0027,{"RBH","RBG","RBK","RBL"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)	
oSection8:SetTotalInLine(.F.)  
oSection8:SetHeaderBreak()
oSection8:ShowHeader(.T.) 	//Imprime Cabecalho da Secao
oSection8:SetLeftMargin(2)	//Identacao da Secao  

TRCell():New(oSection8,"RBH_CODCOM","RBH")			//Codigo da Competencia
TRCell():New(oSection8,"RBH_ITECOM","RBH")			//Codigo do Item da Competencia
TRCell():New(oSection8,"RBH_HABIL","RBH")		  	//Codigo da Habilidade
TRCell():New(oSection8,"RBG_DESC","RBG","",,20)	//Descricao da Habilidade
TRCell():New(oSection8,"RBH_ESCALA"	,"RBH") 		//Escala
TRCell():New(oSection8,"RBK_DESCRI"	,"RBK","",,20) 	//Descricao da Escala
TRCell():New(oSection8,"RBH_ITESCA"	,"RBH") 		//Item de Escala
TRCell():New(oSection8,"RBL_DESCRI"	,"RBL","",,20)	//Descricao do Item de Escala 
TRCell():New(oSection8,"RBH_IMPORT"	,"RBH")			//Grau de Importancia
TRCell():New(oSection8,"RBK_DESCRI"	,"RBK","",,20) 	//Descricao do Grau de Importancia
TRCell():New(oSection8,"RBH_ITIMPO"	,"RBH")			//Item de Importancia  
TRCell():New(oSection8,"RBL_DESCRI"	,"RBL","",,20,,{|| FDesc("RBL",RBH->RBH_IMPORT + RBH->RBH_ITIMPO,"RBL_DESCRI",20) })	//Descricao do Item de Importancia 

TRPosition():New(oSection8,"RBG",1,{|| RhFilial("RBG",RBH->RBH_FILIAL) + RBH->RBH_HABIL }) 
TRPosition():New(oSection8,"RBK",1,{|| RhFilial("RBK",RBH->RBH_FILIAL) + RBH->RBH_ESCALA }) 
TRPosition():New(oSection8,"RBL",1,{|| RhFilial("RBL",RBH->RBH_FILIAL) + RBH->RBH_ESCALA + RBH->RBH_ITESCA })

Return oReport          

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef() ³ Autor ³ Eduardo Ju          ³ Data ³ 21.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do Relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport)

Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)  
Local oSection3 := oReport:Section(1):Section(2)
Local oSection4 := oReport:Section(1):Section(3)
Local oSection5 := oReport:Section(1):Section(4)
Local oSection6 := oReport:Section(1):Section(5)
Local oSection7 := oReport:Section(1):Section(6)
Local oSection8 := oReport:Section(1):Section(7)
Local cAcessaSQ3:= &("{ || " + ChkRH(FunName(),"SQ3","2") + "}")
Local cFiltro 	:= ""
Local cFiltroSQ4:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros               ³
//³ MV_PAR01 - "Filial ?"                              ³
//³ MV_PAR02 - "Cargo ?"                               ³
//³ MV_PAR03 - "Grupo ?"                               ³
//³ MV_PAR04 - "Impr Descr Detalh ?"                   ³
//³ MV_PAR05 - "Impr.Responsabilid. do Cargo ?"        ³
//³ MV_PAR06 - "Impr.Relacionamento do Cargo ?"        ³
//³ MV_PAR07 - "Impr.Habilidades do Cargo ?"           ³
//³ MV_PAR08 - "Impr Graduacao ?"                      ³
//³ MV_PAR09 - "Fator Graduacao De ?"                  ³
//³ MV_PAR10 - "Impr Graduac Detalh ?"                 ³
//³ MV_PAR11 - "Imprime Pontos ?"                      ³
//³ MV_PAR12 - "Somente Totais Ptos ?"                 ³
//³ MV_PAR13 - "Impr Cursos ?"                         ³
//³ MV_PAR14 - "Competencias/Habilidades ?"            ³
//³ MV_PAR15 - "Impr Cargo p/Folha ?"                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Descricao Detalhada do Cargo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR04 <> 1
	oSection2:Disable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Descricao das Responsabilidades do Cargo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR05 <> 1
	oSection3:Disable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Descricao Relacionamento Interno do Cargo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR06 <> 1
	oSection4:Disable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Descricao das Habilidades do Cargo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR07 <> 1
	oSection5:Disable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Graduacao do Cargo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR08 <> 1
	oSection6:Disable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cursos do Cargo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR13 <> 1
	oSection7:Disable()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Competencias/Habilidades ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR14 <> 1 
	oSection8:Disable()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Cargo por Folha   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR15 == 1   		
	oSection1:SetPageBreak(.T.) //Salta Pagina		
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Transforma parametros Range em expressao (intervalo) ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeAdvplExpr("TR010R")	                                  

If !Empty(MV_PAR01) .And. !Empty(xFilial("SQ3"))
	cFiltro:= MV_PAR01
EndIf  

If !Empty(MV_PAR02) 
	cFiltro += Iif(!Empty(cFiltro)," .And. ","")
	cFiltro += MV_PAR02 
EndIf  
       
If !Empty(MV_PAR03)
	cFiltro += Iif(!Empty(cFiltro)," .And. ","")
	cFiltro += MV_PAR03
EndIf  

If !Empty(MV_PAR09)
	cFiltroSQ4 := MV_PAR09
EndIf  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtra Tabela Principal e Secundaria  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:SetFilter(cFiltro)   
oSection1:Setfilter(cFiltroSQ4,,,"SQ4")

oSection1:SetLineCondition(cAcessaSQ3)
       
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Condicao para Impressao   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
oSection2:SetParentRecno()
oSection3:SetParentRecno()
oSection4:SetParentRecno()
oSection5:SetParentRecno()

oSection6:SetRelation({|| xFilial("SQ4")+SQ3->Q3_CARGO},"SQ4",1,.T.)
oSection6:SetParentFilter({|cParam| SQ4->Q4_CARGO == cParam},{|| SQ3->Q3_CARGO})	                             

oSection7:SetRelation({|| xFilial("RA5")+SQ3->Q3_CARGO+SQ3->Q3_CC},"RA5",2,.T.)
oSection7:SetParentFilter({|cParam| RA5->RA5_CARGO + RA5->RA5_CC == cParam},{|| SQ3->Q3_CARGO + SQ3->Q3_CC})	

oSection8:SetRelation({|| xFilial("RBH")+SQ3->Q3_GRUPO + SQ3->Q3_CARGO},"RBH",1,.T.)
oSection8:SetParentFilter({|cParam| RBH->RBH_GRUPO + RBH->RBH_CARGO == cParam},{|| SQ3->Q3_GRUPO + SQ3->Q3_CARGO})	
                              
oReport:SetMeter(SQ3->(LastRec()))	
oSection1:Print() //Imprimir 
	
Return Nil