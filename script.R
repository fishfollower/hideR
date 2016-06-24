library(TMB)

get.stuff <- function(filen){
  lin <- readLines(filen)
  idxNam <- grep("^[[:alpha:]]", lin)
  doone <- function(i){
    idxNam <- c(idxNam,length(lin)+1)
    x <- read.table(textConnection(lin[(idxNam[i]+1):(idxNam[i+1]-1)]))
    names(x) <- NULL
    if((nrow(x)==1) | (ncol(x)==1)){
      x <- as.numeric(x)
    }else{
      x <- as.matrix(x)
    }
    x
  }
  ret <- lapply(1:length(idxNam), doone)
  nam <- lin[idxNam]
  nam <- sub('RANDOM', '', nam)
  nam <- sub('[[:space:]]+', '', nam)
  names(ret) <- nam
  ret
}

get.random <- function(filen){
  lin <- readLines(filen)
  idxNam <- grep("^[[:alpha:]]", lin)
  nam <- lin[idxNam]
  nam<-nam[grep("RANDOM", nam)]
  nam <- sub('RANDOM', '', nam)
  nam <- sub('[[:space:]]+', '', nam)
  if(length(nam)==0){
    nam <- NULL
  }
  nam
}    

runit <- function(name){
  compile(paste(name,".cpp", sep=""))
  dyn.load(dynlib(name))
  data <- get.stuff(paste(name, ".dat", sep=""))
  param <- get.stuff(paste(name, ".pin", sep=""))
  ran <- get.random(paste(name, ".pin", sep=""))
  obj <- MakeADFun(data, param, random=ran, DLL=name)
  opt <- nlminb(obj$par, obj$fn, obj$gr)
  rep<-sdreport(obj)
  sink(file=paste(name, ".std", sep=""))
  print(summary(rep))
  sink()
}
