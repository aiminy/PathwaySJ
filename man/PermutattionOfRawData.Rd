% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PermutationOfRawData.R
\name{PermutattionOfRawData}
\alias{PermutattionOfRawData}
\title{Title}
\usage{
PermutattionOfRawData(dir.name, file.sample, file.count, file.gff)
}
\arguments{
\item{file.gff}{}
}
\description{
Title
}
\examples{

dir.name="/Volumes/Bioinformatics$/2015/Nimer_Cheng/"
file.sample="decoder.bySample.txt"
file.count="_junction_seq_new_gtf_7/QC.spliceJunctionAndExonCounts.forJunctionSeq.txt"
file.gff="Mus_musculus.GRCm38.83.JunctionSeq.flat.gff"
Re<-PermutattionOfRawData(dir.name,file.sample,file.count,file.gff)

}

