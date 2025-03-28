CNPJ Alfanumérico: Validação do Novo Formato Brasileiro


Introdução
Em 2026, o Cadastro Nacional da Pessoa Jurídica (CNPJ) passará por uma transformação histórica, adotando um formato alfanumérico. Essa mudança, regulamentada pela Instrução Normativa RFB nº 2.229/2024 e detalhada na Nota Técnica COCAD/SUARA/RFB nº 49/2024, visa ampliar a capacidade de registros e evitar o esgotamento das combinações numéricas disponíveis. Este repositório apresenta a implementação em PL/SQL para validação do novo CNPJ, com foco na verificação dos dígitos calculados por módulo 11 utilizando a conversão de caracteres via código ASCII.

O que muda com o novo CNPJ alfanumérico?
Formato:
O novo CNPJ manterá 14 posições, porém, sua composição interna será alterada:

Posições 1 a 8: Raiz do CNPJ – alfanumérica (letras e números).

Posições 9 a 12: Ordem do estabelecimento – alfanumérica (letras e números).

Posições 13 e 14: Dígitos verificadores – numéricos.

Cálculo dos Dígitos Verificadores:
O algoritmo permanece o mesmo (módulo 11), porém, os caracteres alfanuméricos serão convertidos em valores numéricos utilizando o código ASCII, subtraindo 48. Assim, os dígitos continuam valendo 0 a 9 e as letras terão valores:

A = 17, B = 18, C = 19, ... até Z.

Impactos:

Maior Capacidade: Quase um trilhão de combinações possíveis.

Segurança: Dificulta falsificações.

Integração: CNPJs existentes permanecem válidos, facilitando a transição.

Econômico: Solução de baixo custo e alta longevidade para os registros.

Estrutura do Código

valida_cnpj_alfanumerico
Esta função recebe o CNPJ completo (14 caracteres), remove formatações, valida o padrão e compara os dígitos verificadores informados com os calculados pela função anterior.

CNPJ Alfanumérico: Validação do Novo Formato Brasileiro


Introdução
Em 2026, o Cadastro Nacional da Pessoa Jurídica (CNPJ) passará por uma transformação histórica, adotando um formato alfanumérico. Essa mudança, regulamentada pela Instrução Normativa RFB nº 2.229/2024 e detalhada na Nota Técnica COCAD/SUARA/RFB nº 49/2024, visa ampliar a capacidade de registros e evitar o esgotamento das combinações numéricas disponíveis. Este repositório apresenta a implementação em PL/SQL para validação do novo CNPJ, com foco na verificação dos dígitos calculados por módulo 11 utilizando a conversão de caracteres via código ASCII.

O que muda com o novo CNPJ alfanumérico?
Formato:
O novo CNPJ manterá 14 posições, porém, sua composição interna será alterada:

Posições 1 a 8: Raiz do CNPJ – alfanumérica (letras e números).

Posições 9 a 12: Ordem do estabelecimento – alfanumérica (letras e números).

Posições 13 e 14: Dígitos verificadores – numéricos.

Cálculo dos Dígitos Verificadores:
O algoritmo permanece o mesmo (módulo 11), porém, os caracteres alfanuméricos serão convertidos em valores numéricos utilizando o código ASCII, subtraindo 48. Assim, os dígitos continuam valendo 0 a 9 e as letras terão valores:

A = 17, B = 18, C = 19, ... até Z.

Impactos:

Maior Capacidade: Quase um trilhão de combinações possíveis.

Segurança: Dificulta falsificações.

Integração: CNPJs existentes permanecem válidos, facilitando a transição.

Econômico: Solução de baixo custo e alta longevidade para os registros.

Estrutura do Código

valida_cnpj_alfanumerico
Esta função recebe o CNPJ completo (14 caracteres), remove formatações, valida o padrão e compara os dígitos verificadores informados com os calculados pela função anterior.


Considerações Finais
Compatibilidade: As funções foram desenvolvidas para Oracle 19c e utilizam recursos padrão do PL/SQL, garantindo fácil integração em sistemas legados e novos.

Robustez: São realizadas verificações de formato, comprimento e sequências inválidas para evitar falsos positivos.

Futuras Atualizações: Mantenha o código atualizado conforme novas orientações da Receita Federal ou ajustes nos requisitos da reforma tributária.

Esta documentação e as funções associadas foram desenvolvidas para auxiliar desenvolvedores e equipes de TI na adaptação dos sistemas ao novo formato do CNPJ brasileiro. Ajuste conforme necessário para atender às especificidades do seu ambiente de desenvolvimento.

Para mais informações, consulte a Nota Técnica COCAD/SUARA/RFB nº 49/2024 e a Instrução Normativa RFB nº 2.229/2024.


