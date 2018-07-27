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
    all p:Plano | one p.~plano
 
    --Não existe serviço sem plano
    all s:Servico | #(s.~servicos) = 1
 
    all s:Simple | #(s.servicos) = 1
    all d:Double | #(d.servicos) = 2
    all c:Combo | #(c.servicos) = 3
 
    --A interseção entre os serviços e cada tipo deve ser
    -- 1 ou nenhum para que não existam dois serviços
    -- do mesmo tipo no mesmo plano
    all p:Plano | #(p.servicos & TV) < 2
    all p:Plano | #(p.servicos & Telefone) < 2
    all p:Plano | #(p.servicos & Internet) < 2
 
    --Não existe velocidade sem Internet
    all v:Velocidade | #(v.~velocidade) = 1
 
    --Não existe canal sem TV
    all canal:CanalTV | #(canal.~canais) = 1
 
    --Não existe plano de ligação sem Telefone
    all p:PlanoLigacoes | #(p.~planoLigacao) = 1
 
    --A interseção entre os canais e cada tipo deve ser
    -- 1 ou nenhum para que não existam dois canais
    -- do mesmo tipo no mesmo plano de TV
    all tv:TV | #(tv.canais & Noticias ) < 2
    all tv:TV | #(tv.canais & Infantis ) < 2
    all tv:TV | #(tv.canais & Filmes ) < 2
    all tv:TV | #(tv.canais & Documentarios ) < 2
    all tv:TV | #(tv.canais & Series ) < 2
    all tv:TV | #(tv.canais & ProgramasDeTV ) < 2

    all i:Internet | #(i.velocidade & V5Megas) < 2
    all i:Internet | #(i.velocidade & V35Megas) < 2
    all i:Internet | #(i.velocidade & V60Megas) < 2
    all i:Internet | #(i.velocidade & V120Megas) < 2
        
}
 
pred show[]{}
 
run show for 5
