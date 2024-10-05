#' Predição valores novos
#'
#' Esta função realiza a predição de novos dados baseados no modelo ajustado.
#'
#' @param nova_matriz Matriz de novos preditores.
#' @param beta Coeficientes do modelo ajustado.
#' @return Valores preditos para os novos dados.
#' @export
predizer_novos_valores <- function(nova_matriz, modelo) {
  if (!is.matrix(nova_matriz) || !is.numeric(nova_matriz)) stop("nova_matriz deve ser uma matriz numérica.")

  nova_matriz <- cbind(1, nova_matriz)
  for (i in 2:ncol(nova_matriz)){
    if (any(nova_matriz[,i] > max(modelo$matrizX[,i]) | any(nova_matriz[,i] < min(nova_matriz[,i])))) {
      warning("Predição extrapola os limites da amostra. Valores preditos podem não ser confiáveis.")
    }
  }
  predicoes <- nova_matriz %*% modelo$coeficientes[,1]

  return(predicoes)
}
