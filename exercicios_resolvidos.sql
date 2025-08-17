
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