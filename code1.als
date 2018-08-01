/* Integrantes:
 * Daniel Barreto Torres
 * Izaquiel Nascimento
 * Axél Medeiros
 * Lucas Aires
 *
 * Tema 25: Empresa de Telecomunicações
 * Cliente: Kyler
*/
	
module telecomunicacoes

// Representação da empresa fornecedora dos serviços 
one sig Empresa{
    assinantes: set Assinante
}

// Representação dos clientes(assinantes de um plano)
sig Assinante{
    plano: one Plano
}

// Representação abstrata dos planos individuais consumidos pelos assinantes
abstract sig Plano{
    servicos: set Servico
}

// Plano que só oferece um serviço
sig Simple extends Plano{}

// Plano que oferece dois tipos de serviços
sig Double extends Plano{}

// Plano que oferece os três tipos de serviços oferecidos
sig Combo extends Plano{}

// Representação abstrata de um serviço 
abstract sig Servico{}

// Representação do serviço de tv oferecido pela empresa
sig TV extends Servico{
    canais: some CanalTV
}

// representação do servico de internet
sig Internet extends Servico{
    velocidade: one Velocidade
}

// Representação do serviço de telefone 
sig Telefone extends Servico{
    planoLigacao: one PlanoLigacoes
}
 
// Representação abstrata de um canal
abstract sig CanalTV{}

//Canais que podem ser incorporados ao serviço de tv
sig Noticias, Infantis, Filmes, Documentarios, Series, ProgramasDeTV extends CanalTV{}

// Representação abstrata de um plano de telefone
abstract sig PlanoLigacoes{}

// Planos telefônicos oferecidos
sig LimitadoLocal, IlimitadoLocal, IlimitadoBrasil, IlimitadoMundo extends PlanoLigacoes{}

// Representação abstrata de uma velocidade de internet 
abstract sig Velocidade{}

// Velocidades de internet oferecidas
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

assert todoAssinanteTemUmPlano{
    all a:Assinante | #(a.plano) = 1
}

assert todoPlanoTemServico{
    all p:Plano | #(p.servicos) >= 1
}

assert todaTVTemCanal{
    all tv:TV | some tv.canais
}

assert todaInternetTemUmaVelocidade{
    all i:Internet | one i.velocidade
}

assert todoTelefoneTemUmPlanoDeLigacao{
    all t:Telefone | one t.planoLigacao
}

check todoAssinanteTemUmPlano for 5
check todoPlanoTemServico for 5
check todaTVTemCanal for 5
check todaInternetTemUmaVelocidade for 5
check todoTelefoneTemUmPlanoDeLigacao for 5

pred show[]{}
 
run show for 5
