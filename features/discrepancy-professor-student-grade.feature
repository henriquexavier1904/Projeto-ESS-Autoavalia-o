Feature: Como professor
         Eu quero visualizar as discrepâncias entre as notas de autoavaliação dos alunos e as notas que atribuí
         Para identificar rapidamente quais alunos avaliaram a si mesmos de forma muito diferente da minha avaliação

Scenario: listar alunos com discrepância acima do limite definido
Given que estou na página de discrepâncias da turma "Turma A"
And o limite de discrepância definido é "1.5"
And a turma "Turma A" possui alunos com nota de autoavaliação e nota do professor cadastradas
When eu acesso a página de discrepâncias da turma
Then devo ver apenas os alunos cuja diferença entre a nota de autoavaliação e a nota do professor seja maior que "2.0"
And devo ver a quantidade de alunos discrepantes
And devo ver o percentual de alunos discrepantes em relação ao total de alunos da turma

Scenario: nenhum aluno discrepante na turma
Given que estou na página de discrepâncias da turma "Turma B"
And o limite de discrepância definido é "2.0"
And todos os alunos da turma "Turma B" possuem diferença entre a nota de autoavaliação e a nota do professor menor ou igual a "2.0"
When eu acesso a página de discrepâncias da turma
Then devo ver a quantidade de alunos discrepantes igual a "0"
And devo ver a lista de alunos discrepantes vazia

Scenario: falha ao acessar discrepâncias de turma inexistente
Given que não existe a turma "Turma Z"
When eu tento acessar a página de discrepâncias da turma "Turma Z"
Then devo ver uma mensagem de erro informando que a turma não foi encontrada

Scenario: falha ao calcular discrepância por falta de nota do professor
Given que estou na página de discrepâncias da turma "Turma C"
And o aluno "Maria" possui nota de autoavaliação cadastrada, mas não possui nota do professor cadastrada
When eu acesso a página de discrepâncias da turma
Then devo ver uma mensagem indicando que a discrepância do aluno "Maria" não pôde ser calculada
And o aluno "Maria" não deve ser contabilizado na quantidade de alunos discrepantes
And devo ver uma sugestão para que eu cadastre a nota pendente do aluno "Maria"

Scenario: aluno com diferença de nota exatamente igual ao limite não é considerado discrepante
Given que estou na página de discrepâncias da turma "Turma D"
And o limite de discrepância definido é "2.0"
And o aluno "João" possui diferença entre a nota de autoavaliação e a nota do professor igual a "2.0"
When eu acesso a página de discrepâncias da turma
Then o aluno "João" não deve aparecer na lista de alunos discrepantes

Scenario: professor filtra alunos discrepantes por ordem decrescente de diferença de nota
Given que estou na página de discrepâncias da turma "Turma E"
And o limite de discrepância definido é "1.0"
And a turma "Turma E" possui os alunos discrepantes:
  | aluno   | diferença de nota |
  | Carlos  | 4.0                |
  | Beatriz | 3.5                |
  | Rafael  | 1.5                |
When eu ordeno a lista de alunos discrepantes por diferença de nota decrescente
Then devo ver os alunos discrepantes na ordem "Carlos", "Beatriz", "Rafael"

Scenario: professor recebe notificação de novos alunos discrepantes após atualização de notas
Given que estou cadastrado para receber notificações da turma "Turma H"
And um novo aluno da turma "Turma H" passa a ter diferença de nota acima do limite definido
When o sistema recalcula as discrepâncias da turma
Then devo receber uma notificação informando o novo aluno discrepante
