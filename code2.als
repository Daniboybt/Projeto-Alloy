module telecomunicacoes
 
// Representa um assinante, que tem um plano
sig Assinante {
    assina: one Plano
}
 
 // Representa o plano
sig Plano {
   p : one Servico
}
 
// O Plano pode ser Simples, Double ou Combo
sig Simples, Double, Combo  extends Plano{
}
 
// Classe Servico
abstract sig Servico {}
 
//Servico internet
sig Internet extends Servico{
    limitado: one Velocidade
}
 
//Servico Tv
sig Tv extends Servico {
    contem: some CanaisTV
}
 
//Servico Telefone
sig Telefone extends Servico {
    plano: one PlanoDeLigacoes
}
 
 // objetivo: criar os fatos e as funções adequadamente
 
 
fact {
   all assina:Assinante | some possuiPlano[assina]
   // all plano: Plano | lone Assinante[assina]
   // all s: Servico | (s in Internet || s in Tv || s in Telefone)
 
}
 
//funções
// arrumar o retorno
fun possuiPlanoSimples[ p : Plano]: set Simples{
    p.Simples
   
}
 
 
 
 
 
--fact {
   -- all s:Servico | (#s.~possui) > 0
 
--  all i: Internet | (#i.~possui) = 1
--  all t: Telefone | (#t.~possui) = 1
 
 
    --all v:Velocidade |  (#v.~limitado) = 1
    --all p:PlanoDeLigacoes | (#p.~plano) = 1
 
    --all c:CanaisTV | (#c.~contem) = 1
--}
 
abstract sig Velocidade {}
sig Velocidade5Megas extends Velocidade {}
sig Velocidade35Megas extends Velocidade {}
sig Velocidade60Megas extends Velocidade {}
sig Velocidade120Megas extends Velocidade {}
 
 
 
abstract sig CanaisTV {}
sig Noticias, Infantis, Filmes, Documentarios, Series, ProgramasDeTV in CanaisTV{}
 
 
abstract sig PlanoDeLigacoes {}
sig IlimitadoLocal, limitadoBrasil, lmitadoMundo extends PlanoDeLigacoes {}
 
pred show[] {
    #Servico = 3
}
 
run show for 5
