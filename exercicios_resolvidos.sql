
-- Um funcionário cadastrou o nome do cliente errado, atualize o nome do cliente com cpf 68745120480 para “João”

update clientes set nome='João' where cpf='68745120480';

-- Mariana (cpf 23548754210) se divorciou, atualize a base de dados

update clientes set estado_civil='Divorciado' where cpf='23548754210';


-- O veículo código 103 está com o comprimento errado, o valor correto é 18 metros.

update veiculos set comprimento=18 where matricula=103;


-- Todos os barcos devem sofrer uma alteração em suas diárias. Reajuste em 12.4% todos os valores de diárias

update veiculos set vldiaria=vldiaria*1.124 where codtipo!=2;

-- O funcionário Marquito foi demitido, exclua ele da base.

delete from funcionarios where nome='Marquito';

-- 1) Listar o nome e o estado civil e a data de nascimento de todos os clientes

select nome, estado_civil, data_nasc from clientes;

-- 2) Listar o nome, idade e telefone de todos os funcionarios

select nome, idade, telefone from funcionarios;

-- 3) Liste as habilitações que necessitam que o usuário possua mais de 25 anos 

select * from habilitacoes where idade_min > 25;

-- 4) Listar o nome dos veiculos que tem comprimento maior que 10 e com potencia superior a 120

select nome from veiculos where comprimento > 10 and potmotor>120;

-- 5) Listar o nome e o comprimento de todos os barcos cuja potencia fique entre 50 e 300

select nome, comprimento from veiculos where codtipo != 2 and potmotor between 50 and 300;

-- 6) Busque a maior e a menor diária dentre os barcos
select * from veiculos where vldiaria in (select max(vldiaria) from veiculos);
select * from veiculos where vldiaria in (select min(vldiaria) from veiculos);

-- 7) Conte o número de locações que se iniciaram no dia ‘2021-12-29’

select count(*) from locacoes where inicio='2021-12-29';

-- 8) Apresente a idade do funcionário mais novo, do funcionário mais velho e a média de idades de todos os funcionários

select min(idade) from funcionarios;
select max(idade) from funcionarios;
select avg(idade) from funcionarios;

-- 9) Liste os estados civis cadastrados (sem repetir)
select distinct estado_civil from clientes;

-- 10) Liste os nomes de todas as pessoas cadastradas (funcionários + clientes)

select nome from clientes UNION select nome from funcionarios;

-- estudar funções de agregação -- array_agg, string_agg


-- 1) Liste os nomes dos veículos e seus respectivos tipos (descrição do tipo)

select v.nome, t.descricao from veiculos v join tipos_veiculos t on v.codtipo  = t.codtipo ;

-- 2) Apresente o nome dos funcionários que fizeram locações no dia 17/02/2022

select f.nome from funcionarios f join locacoes l on f.codf = l.codf where inicio='2022-02-17';

-- 3) Liste o nome, num_filhos, estado civil e descrição da habilitação de todos os clientes

select c.nome, c.num_filhos, c.estado_civil, h.descricao from clientes c join habilitacao h on c.codh = h.codh;

-- 4) Apresente os dados da locação (nome do barco, potencia, descrição do tipo, data inicio, data fim, nome do funcionário resposável) feito por João (68745120480)

select v.nome, v.potmotor, t.descricao, l.inicio, l.fim, f.nome from veiculos v join tipos_veiculos t on v.codtipo = t.codtipo join locacoes l on v.matricula = l.matricula join funcionarios f on l.codf = f.codf where l.cpf='68745120480';

-- 5) Apresente quantos veículos estão cadastrados para cada um dos tipos

select codtipo, count(*) from veiculos group by codtipo;
select t.descricao, count(v.matricula) from veiculos v join tipos_veiculos t on t.codtipo = v.codtipo group by t.descricao;

-- 6) Considerando as habilitações, apresente quantos veículos estão cadastrados para cada uma das categorias de habilitação



-- 7) Apresente o veículo mais e menos locado

-- mais locado
with total_locacoes as (
    select v.nome as nome, count(l.matricula) as total from veiculos v join locacoes l on v.matricula = l.matricula group by v.nome
)
select nome, total
from total_locacoes
where total = (select max(total) from total_locacoes);

-- menos locado
with total_locacoes as (
    select v.nome as nome, count(l.matricula) as total from veiculos v join locacoes l on v.matricula = l.matricula group by v.nome
)
select nome, total
from total_locacoes
where total = (select min(total) from total_locacoes);


-- 8) Qual o funcionário que mais participou de locações
with total_locacoes as (
    select f.nome as nome, count(l.codf) as total from funcionarios f join locacoes l on f.codf = l.codf group by f.nome
)
select nome
from total_locacoes
where total = (select max(total) from total_locacoes);

-- 9) Em média quantos dias duram as locações?

with dias as (select fim - inicio as total_dias from locacoes)
select avg(total_dias) from dias;


-- 10) Considerando o tipo de embarcação, qual a média de dias que cada tipo de embarcação fica locada

-- fazer um count agrupado por tipo de embarcação, e depois fazer a média

with total_dias_por_tipo as (
select 
    tp.descricao as descricao_tipo, 
    l.fim - l.inicio as total_dias
from locacoes l 
join veiculos v on l.matricula = v.matricula 
join tipos_veiculos tp on v.codtipo = tp.codtipo
group by tp.descricao, l.fim - l.inicio
)
select descricao_tipo, avg(total_dias) from total_dias_por_tipo group by descricao_tipo;


-- 11) Para cada locação apresente o funcionário resposável, o nome do barco, o nome do cliente e o valor calculado da locação

select f.nome, v.nome, c.nome, ((l.fim - l.inicio) * v.vlDiaria) as valor_total_locacao
from locacoes l join funcionarios f on f.codf = l.codf 
join veiculos v on v.matricula = l.matricula 
join clientes c on c.cpf = l.cpf;


-- 1) Apresente quantos barcos foram locados por dia (considerando data inicial)

select inicio, count(*) from locacoes group by inicio;

-- 2)Verifique quais o cpfs possuem mais de duas locações 

select cpf, count(*) as total from locacoes group by cpf having count(*) >2;


