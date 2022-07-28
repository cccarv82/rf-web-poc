### Funcionalidade de Login

> Sendo um usuário administrador desejo poder realizar login no sistema

##### Login com sucesso - [x]

Dado que acesso a página de login
Quando faço login como Administrador
Então sou redirecionado para o Dashboard

##### Senha incorreta - [x]

Dado que informo a senha incorreta na página de login
Então o sistema deve apresentar a mensagem "Usuário ou senha inválido"

##### Email não cadastrado - [x]

Dado que informo um email não cadastrado na página de login
Então o sistema deve apresentar a mensagem "Usuário ou senha inválido"

##### Email incorreto - [x]

Dado que informo um email incorreto
Então o sistema deve apresentar a mensagem "Informe um e-mail válido"

##### Senha não informada - [x]

Dado que tento submeter o formulário de login sem informar a senha
Então o sistema deve apresentar a mensagem "A senha é obrigatória"

##### Email não informado - [x]

Dado que tento submeter o formulário de login sem informar o email
Então o sistema deve apresentar a mensagem "O e-mail é obrigatório"

##### Email e Senha não informados - [x]

Dado que tento submeter o formulário de login sem informar email e senha
Então o sistema deve apresentar as mensagens "A senha é obrigatória" e "O e-mail é obrigatório"

