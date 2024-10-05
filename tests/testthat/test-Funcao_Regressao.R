# Ajuste da Regressão

test_that("Erro de Tipo - X", {
  expect_error(regressao_linear(x = c("1","2","3","4"), y = c(5, 6, 7, 8)))
})

test_that("Erro de Tipo - Y", {
  expect_error(regressao_linear(x = c(1,2,3,4), y = c("5", "6", "7", "8")))
})

test_that("Erro de X e Y com tamanhos diferentes", {
  expect_error(regressao_linear(x = c(1,2,3,4,5), y = c(1,2,3,4)))
})

test_that("Condições Normais - Execução sem erros", {
  expect_no_error(regressao_linear(x = as.matrix(dados_simulados[,1:3]),
                                y = dados_simulados$Y))
})

test_that("Erro de colunas constantes - X", {
  expect_error(regressao_linear(x = c(1,1,1,1), y = c(1,2,3,4)))
})

test_that("Erro de colunas constantes - Y", {
  expect_error(regressao_linear(x = c(1,2,3,4), y = c(1,1,1,1)))
})

test_that("Erro de X com posto incompleto", {
  expect_error(regressao_linear(matrix(c(1, 2, 2, 4, 3, 6), nrow = 3, ncol = 2, byrow = TRUE), y = c(1,4,6)))
})

test_that("Erro de ajuste perfeito", {
  expect_error(regressao_linear(matrix(c(2,4,6,8,3,6,9,16), nrow = 4, ncol = 2), y = c(1,2,3,4)))
})

# Predição

test_that("Aviso de extrapolação", {
  expect_warning(predizer_novos_valores(matrix(c(2,4,2), nrow = 1, ncol = 3), regressao_linear(x = as.matrix(dados_simulados[,1:3]),y = dados_simulados$Y)))
})

test_that("Erro de Tipo", {
  expect_error(predizer_novos_valores(matrix(c("1",4,2), nrow = 1, ncol = 3), regressao_linear(x = as.matrix(dados_simulados[,1:3]),y = dados_simulados$Y)))
})
