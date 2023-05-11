library(phytools)

tree<-read.tree("Oreina_datasetC_BEAST_nooutgroups.newick")
x0<-read.csv("Oreina_hostplant_matrix.csv",header=T,row.names=1,sep=";")
x<-as.matrix(x0)

atrees<-make.simmap(tree,x,nsim=1000,model="ER")
cols<-setNames(colorRampPalette(c("limegreen","darkblue","red","gold","dodgerblue","purple","darkorange","grey"))(8),colnames(x))
plot(summary(atrees),colors=cols,fsize=0.4)
legend(x="topleft",legend=colnames(x),pt.cex=1.5,pch=21,pt.bg=cols,cex=0.8)

atrees<-make.simmap(tree,x2,nsim=1000,model="SYM")
cols<-setNames(colorRampPalette(c("limegreen","darkblue","red","gold","dodgerblue","purple","darkorange","grey"))(8),colnames(x))
plot(summary(atrees),colors=cols,fsize=0.4)
legend(x="topleft",legend=colnames(x),pt.cex=1.5,pch=21,pt.bg=cols,cex=0.8)

atrees<-make.simmap(tree,x2,nsim=1000,model="ARD")
cols<-setNames(colorRampPalette(c("limegreen","darkblue","red","gold","dodgerblue","purple","darkorange","grey"))(8),colnames(x))
plot(summary(atrees),colors=cols,fsize=0.4)
legend(x="topleft",legend=colnames(x),pt.cex=1.5,pch=21,pt.bg=cols,cex=0.8)


#compare models
aic<-function(logL,k) 2*k-2*logL
aic.w<-function(aic){
  d.aic<-aic-min(aic)
  exp(-1/2*d.aic)/sum(exp(-1/2*d.aic))
}

logL<-sapply(c("ER","SYM","ARD"),
             function(model,tree,x) make.simmap(tree,x,model)$logL,
             tree=tree,x=x)

logL
AIC<-mapply(aic,logL,c(1,3,6))
AIC
AIC.W<-aic.w(AIC)
AIC.W