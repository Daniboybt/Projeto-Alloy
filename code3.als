module telecomunicacoes
 
sig Assinante {
    assina: one Plano
}
 
 
abstract sig Plano {
    possui: set Servico
}
 
sig Simple extends Plano{}
sig Double extends Plano{}
sig Combo extends Plano{}
 
 -- Simple, Double ou Combo
 
fact {
    all a:Assinante | #(a.assina) = 1
    all p: Plano | #(p.~assina) > 0
 
    all s:Simple | #(s.possui) = 1
    all d:Double | #(d.possui) = 2
    all c:Combo | #(c.possui) = 3
 
}
 
 
abstract sig Servico {}
sig Internet extends Servico{
    limitado: one Velocidade
}
sig Tv extends Servico{
    contem: one CanaisTV
}
sig Telefone extends Servico{
    plano: one PlanoDeLigacoes
}
 
fact {
    all s:Servico | (#s.~possui) > 0
 
--  all i: Internet | (#i.~possui) = 1
--  all t: Telefone | (#t.~possui) = 1
 
 
    all v:Velocidade |  (#v.~limitado) = 1
    all p:PlanoDeLigacoes | (#p.~plano) = 1
 
    all c:CanaisTV | (#c.~contem) = 1
}
 
abstract sig Velocidade {}
sig Velocidade5Megas extends Velocidade {}
sig Velocidade35Megas extends Velocidade {}
sig Velocidade60Megas extends Velocidade {}
sig Velocidade120Megas extends Velocidade {}
 
 
 
abstract sig CanaisTV {}
sig Noticias, Infantis, Filmes, Documentarios, Series, ProgramasDeTV in CanaisTV{}
 
 
abstract sig PlanoDeLigacoes {}
sig IlimitadoLocal extends PlanoDeLigacoes {}
sig IlimitadoBrasil extends PlanoDeLigacoes {}
sig IlimitadoMundo extends PlanoDeLigacoes {}
 
pred show[] {
    #Servico = 3
}
 
run show for 5
