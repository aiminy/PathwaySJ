#' Plot the probability Weighting Function
#'
#' @param pwf: The first step of the pathway analysis is to assess if there is any systematic bias of the significant genes. The plotPWF function takes input a vector of genes (with label 1 as significant and 0 otherwise), and the bias factor to be adjusted (e.g. number of splice junctions in the genes). The output of the function is a figure that illustrates the relationship between bias factor and proportion of significant genes. The size of the gene set size (i.e. number of genes in each gene bin) on the x-axis can be adjusted by user. 
#' @param binsize
#' @param pwf_col
#' @param pwf_lwd
#' @param xlab
#' @param ylab
#' @param ...
#'
#' @return
#' @export
#'
#' @examples

plotPWF2<-function (pwf, binsize = "auto", pwf_col = 3, pwf_lwd = 2, xlab = "Biased Data in <binsize> gene bins.",
          ylab = "Proportion DE", ...)
{
  w = !is.na(pwf$bias.data)
  print(w)
  o = order(pwf$bias.data[w])
  print(o)

  rang = max(pwf$pwf, na.rm = TRUE) - min(pwf$pwf, na.rm = TRUE)
  if (rang == 0 & binsize == "auto")
    binsize = 1000
  if (binsize == "auto") {
    binsize = max(1, min(100, floor(sum(w) * 0.08)))
    resid = rang
    oldwarn = options()$warn
    options(warn = -1)
    while (binsize <= floor(sum(w) * 0.1) & resid/rang >
           0.001) {
      binsize = binsize + 100
      splitter = ceiling(1:length(pwf$DEgenes[w][o])/binsize)
      de = sapply(split(pwf$DEgenes[w][o], splitter), mean)
      binlen = sapply(split(as.numeric(pwf$bias.data[w][o]),
                            splitter), mean)
      resid = sum((de - approx(pwf$bias.data[w][o], pwf$pwf[w][o],
                               binlen)$y)^2)/length(binlen)
    }
    options(warn = oldwarn)
  }
  else {
    splitter = ceiling(1:length(pwf$DEgenes[w][o])/binsize)
    print(splitter)
    de = sapply(split(pwf$DEgenes[w][o], splitter), mean)
    print(de)
    binlen = sapply(split(as.numeric(pwf$bias.data[w][o]),
                          splitter), median)
    print(binlen)
  }
  xlab = gsub("<binsize>", as.character(binsize), xlab)
  if ("xlab" %in% names(list(...))) {
    if ("ylab" %in% names(list(...))) {
      plot(binlen, de, ...)
    }
    else {
      plot(binlen, de, ylab = ylab, ...)
    }
  }
  else if ("ylab" %in% names(list(...))) {
    plot(binlen, de, xlab = xlab, ...)
  }
  else {
    plot(binlen, de, xlab = xlab, ylab = ylab, ...)
  }
  lines(pwf$bias.data[w][o], pwf$pwf[w][o], col = pwf_col,
        lwd = pwf_lwd)

 return(de)

}
