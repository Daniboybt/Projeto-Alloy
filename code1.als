module telecomunicacoes
 
one sig Empresa{
    assinantes: set Assinante
}
 
sig Assinante{
    plano: one Plano
}
 
abstract sig Plano{
    servicos: set Servico
}
 
sig Simple extends Plano{}
sig Double extends Plano{}
sig Combo extends Plano{}
 
abstract sig Servico{}
 
sig TV extends Servico{
    canais: some CanalTV
}
 
sig Internet extends Servico{
    velocidade: one Velocidade
}
 
sig Telefone extends Servico{
    planoLigacao: one PlanoLigacoes
}
 
 
abstract sig CanalTV{}
sig Noticias, Infantis, Filmes, Documentarios, Series, ProgramasDeTV extends CanalTV{}
 
abstract sig PlanoLigacoes{}
sig LimitadoLocal, IlimitadoLocal, IlimitadoBrasil, IlimitadoMundo extends PlanoLigacoes{}
 
abstract sig Velocidade{}
sig V5Megas, V35Megas, V60Megas, V120Megas extends Velocidade{}
 
 
fact {
    -- Não existe assinante sem conexão com a empresa
    all a:Assinante | one a.~assinantes
 
    --Não existe plano sem assinante
    all p:Plano | temUmAssinante[p]
 
    --Não existe serviço sem plano
    all s:Servico | #(s.~servicos) = 1
 
    all s:Simple | #(s.servicos) = 1
    all d:Double | #(d.servicos) = 2
    all c:Combo | #(c.servicos) = 3
 
    all p:Plano | semServicoRepetido[p]
 
    --Não existe velocidade sem Internet
    all v:Velocidade | #InternetsDaVelocidade[v] = 1
 
    --Não existe canal sem TV
    all c:CanalTV | #TVsDoCanal[c] = 1
 
    --Não existe plano de ligação sem Telefone
    all p:PlanoLigacoes | #TelefonesDoPlano[p] = 1
 
    all tv:TV | semCanaisRepetidos[tv]
        
}

fun InternetsDaVelocidade[v:Velocidade]: set Internet{
    v.~velocidade
}

fun TVsDoCanal[c:CanalTV] : set  TV {
    c.~canais
}

fun TelefonesDoPlano[p:PlanoLigacoes]: set Telefone{
    p.~planoLigacao
} 
 
pred temUmAssinante[p:Plano]{
	one p.~plano
}
pred semServicoRepetido[p:Plano]{
    #(p.servicos & TV) < 2
    #(p.servicos & Telefone) < 2
    #(p.servicos & Internet) < 2
}

pred semCanaisRepetidos[tv:TV]{
    #(tv.canais & Noticias ) < 2
    #(tv.canais & Infantis ) < 2
    #(tv.canais & Filmes ) < 2
    #(tv.canais & Documentarios ) < 2
    #(tv.canais & Series ) < 2
    #(tv.canais & ProgramasDeTV ) < 2
}

pred show[]{}
 
run show for 5
