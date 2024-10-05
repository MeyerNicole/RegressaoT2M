#' @title Regressão Linear
#'
#' @description
#' Esta função realiza a regressão linear e retorna coeficientes, resíduos,
#' valores preditos, a matriz de preditores e um gráfico de valores preditos vs observados.
#'
#' @param x Matriz de preditores.
#' @param y Vetor de resposta.
#' @return Uma lista contendo coeficientes, resíduos, valores preditos, a matriz de preditores e um gráfico.
#' @export
regressao_linear <- function(x, y) {

  if (!is.matrix(x) || !is.numeric(x)) stop("x deve ser uma matriz numérica.")
  if (!is.numeric(y) || length(y) != nrow(x)) stop("y deve ser um vetor numérico com o mesmo número de linhas de x.")
  if (qr(x)$rank != min(nrow(x), ncol(x))) stop("X não tem posto completo, cálculo dos coeficientes produziu NAs.")
  #coluna de 1
  x <- cbind(1, x)

  #testando constância
  for (i in 2:ncol(x)){
    const <- all(x[,i] == x[1,i])
    if (const == TRUE) {
      stop("Uma ou mais variáveis preditoras constantes, cálculo dos coeficientes produziu NAs.")
    }
  }
  const <- all(y == y[1])
  if (const == TRUE) {
    stop("Variável resposta constante.")
  }
  #calculando os coeficientes
  beta_hat <- solve(t(x) %*% x) %*% t(x) %*% y

  #valores preditos e resíduos
  y_pred <- x %*% beta_hat
  residuos <- y - y_pred
  if(all(round(residuos,10) == 0)) stop("Ajuste essencialmente perfeito, cálculo dos coeficientes produziu NaNs, resultados e inferências não são confiáveis.")

  #Gráfico
  plot(y, y_pred, main = "Valores Preditos vs Observados", xlab = "Observados", ylab = "Preditos")
  abline(0, 1, col = "red")

  # Classe para print
  modelo <- list(coeficientes = beta_hat, residuos = residuos, valores_preditos = y_pred, matrizX = x)

  est <- structure(modelo, class = "lmfake")

  print.lmfake <- function(mod) {
    cat("Intercepto:", mod[["coeficientes"]][1], "\n", sep = " ")
    for (i in 2:nrow(mod[["coeficientes"]])) {
      cat(cat("B", i-1, ":", sep = ""), mod[["coeficientes"]][i], "\n", sep = " ")
    }
    invisible(mod)
  }

  print(est)

  return(invisible(modelo))
}

