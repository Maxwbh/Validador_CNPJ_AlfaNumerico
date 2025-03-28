# Validação do Novo CNPJ Alfanumérico Brasileiro

## Introdução

A partir de **julho de 2026**, o Cadastro Nacional da Pessoa Jurídica (CNPJ) no Brasil adotará um formato **alfanumérico**, conforme regulamentado pela **Instrução Normativa RFB nº 2.229/2024** e detalhado na **Nota Técnica COCAD/SUARA/RFB nº 49/2024**. Este documento apresenta uma função para validar o novo CNPJ alfanumérico, utilizando o algoritmo **Módulo 11** adaptado para suportar letras com base na tabela ASCII.

O objetivo é fornecer uma solução prática para desenvolvedores que precisam adaptar seus sistemas ao novo formato, mantendo compatibilidade com os CNPJs numéricos existentes.

---

## Estrutura do Novo CNPJ

O novo CNPJ mantém o tamanho de **14 posições**, mas sua composição interna é alterada:

- **8 primeiras posições**: Alfanuméricas (raiz do número).
- **4 posições seguintes**: Alfanuméricas (ordem do estabelecimento).
- **2 últimas posições**: Numéricas (dígitos verificadores).

**Exemplo**: `A1B2C3D4E5F6G7H8`

---

## Regras de Validação

A validação do CNPJ alfanumérico utiliza o cálculo do **Módulo 11**, ajustado para letras:

1. Cada caractere (número ou letra) é convertido para seu valor decimal na tabela ASCII, subtraindo-se **48**.
2. Os valores resultantes são usados no cálculo tradicional do Módulo 11.
3. Os dois últimos dígitos (verificadores) permanecem numéricos.

### Tabela de Conversão (ASCII - 48)

| Caractere | ASCII | Valor (ASCII - 48) |
|-----------|-------|--------------------|
| `0`       | 48    | 0                  |
| `1`       | 49    | 1                  |
| ...       | ...   | ...                |
| `9`       | 57    | 9                  |
| `A`       | 65    | 17                 |
| `B`       | 66    | 18                 |
| ...       | ...   | ...                |
| `Z`       | 90    | 42                 |

### Pesos do Módulo 11

- **Primeiro dígito verificador**: `[5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]`
- **Segundo dígito verificador**: `[6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]`

---

## Pseudocódigo

```plaintext
FUNÇÃO validarCNPJ(cnpj: STRING) : BOOLEANO
    SE comprimento(cnpj) ≠ 14 ENTÃO
        RETORNE FALSO
    FIM SE

    // Converte caracteres para valores numéricos (ASCII - 48)
    valores ← ARRAY[14]
    PARA i ← 0 ATÉ 13 FAÇA
        valores[i] ← ASCII(cnpj[i]) - 48
    FIM PARA

    // Pesos para o primeiro dígito verificador
    pesos1 ← [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    soma ← 0
    PARA i ← 0 ATÉ 11 FAÇA
        soma ← soma + (valores[i] * pesos1[i])
    FIM PARA

    // Cálculo do primeiro dígito verificador
    resto ← soma % 11
    dv1 ← SE resto < 2 ENTÃO 0 SENÃO 11 - resto FIM SE

    // Verifica o primeiro dígito
    SE dv1 ≠ valores[12] ENTÃO
        RETORNE FALSO
    FIM SE

    // Pesos para o segundo dígito verificador
    pesos2 ← [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    soma ← 0
    PARA i ← 0 ATÉ 12 FAÇA
        soma ← soma + (valores[i] * pesos2[i])
    FIM PARA

    // Cálculo do segundo dígito verificador
    resto ← soma % 11
    dv2 ← SE resto < 2 ENTÃO 0 SENÃO 11 - resto FIM SE

    // Verifica o segundo dígito
    RETORNE dv2 = valores[13]
FIM FUNÇÃO
```

### Observações
- **Compatibilidade:** A função é compatível com CNPJs numéricos existentes e o novo formato alfanumérico.
- **Limitações:** Os dígitos verificadores (posições 13 e 14) devem ser numéricos (0-9).
- **Adaptação de Sistemas:** Bancos de dados que armazenam CNPJs como inteiros precisarão migrar para tipos de texto (ex.: VARCHAR).

### Impactos:
- **Maior Capacidade:** Quase um trilhão de combinações possíveis.
- **Segurança:** Dificulta falsificações.
- **Integração:** CNPJs existentes permanecem válidos, facilitando a transição.
- **Econômico:** Solução de baixo custo e alta longevidade para os registros.

### Estrutura do Código
**valida_cnpj_alfanumerico**

Esta função recebe o CNPJ completo (14 caracteres), remove formatações, valida o padrão e compara os dígitos verificadores informados com os calculados pela função anterior.


### Considerações Finais
- **Compatibilidade:** As funções foram desenvolvidas para Oracle 19c e utilizam recursos padrão do PL/SQL, garantindo fácil integração em sistemas legados e novos.
- **Robustez:** São realizadas verificações de formato, comprimento e sequências inválidas para evitar falsos positivos.
- **Futuras Atualizações:** Mantenha o código atualizado conforme novas orientações da Receita Federal ou ajustes nos requisitos da reforma tributária.

**Esta documentação e as funções associadas foram desenvolvidas para auxiliar desenvolvedores e equipes de TI na adaptação dos sistemas ao novo formato do CNPJ brasileiro. Ajuste conforme necessário para atender às especificidades do seu ambiente de desenvolvimento. Para mais informações, consulte a Nota Técnica COCAD/SUARA/RFB nº 49/2024 e a Instrução Normativa RFB nº 2.229/2024.**


