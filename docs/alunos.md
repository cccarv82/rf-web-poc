### Gestão de Alunos

> Sendo um usuário administrador desejo poder realizar a gestão de alunos
> Contemplando cadastro, edição, consulta e exclusão de alunos

##### Cadastrar novo aluno - [x]

Dado que realizo login no sistema como administrador
E acesso a área de Alunos
Quando acesso a funcionalidade de Cadastrar aluno
E envio o formulário com os dados a serem cadastrados
Então o sistema registra o novo aluno com sucesso
E apresenta as informações cadastradas

##### Bloquear cadastro duplicado de emails - [x]

Dado que realizo login no sistema como administrador
E acesso a área de Alunos
Quando acesso a funcionalidade de Cadastrar aluno
E envio o formulário com os dados a serem cadastrados utilizando um email já cadastrado
Então o sistema deve bloquear o registro
E apresentar mensagem informando o motivo

##### Validar os campos obrigatórios - [ ]

Dado que acesso o formulário de cadastro de aluno
Quando tento submeter o formulário sem preencher as informações obrigatórias
Então o sistema deve apresentar mensagem informando que o campo é obrigatório
