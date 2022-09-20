library(datasets)

data(USJudgeRatings)

library(GGally)

library(ggrepel)

library(gghighlight)

library(gridExtra)

library(grid)

library(ggpubr)

library(SmartEDA)

library(reshape2)

df <- data.frame(USJudgeRatings)

head(df)

df$name = row.names(df)
df$CONT=NULL

mdf <- melt(df,id.vars=c("name"))

head(mdf)

underperform<-ggplot(mdf)+geom_point(aes(x=variable,y=value),color="red")+gghighlight(value<5,use_direct_label = FALSE,unhighlighted_params = list(size = 1, colour = "black"))+geom_label_repel(aes(x=variable,y=value,label=name,force=1))

overperform<-ggplot(mdf)+geom_point(aes(x=variable,y=value),color="red")+gghighlight(value>9,use_direct_label = FALSE,unhighlighted_params = list(size = 1, colour = "black"))+geom_label_repel(aes(x=variable,y=value,label=name,force=1))

combined=grid.arrange(underperform+ rremove("x.text") + rremove("xlab"), overperform+ rremove("x.text")+ rremove("ylab")+ rremove("ylab") + rremove("xlab"), ncol=2)

annotate_figure(combined,left = textGrob("Score out of ten by Lawyer Assesment", rot = 90),bottom = textGrob("Each Vertical Bar Represents a Category the Judge is Assesed on"),top=textGrob("US Superior Court Judge Performance Scores with Outliers Named and Highlighted"))
