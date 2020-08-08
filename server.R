library(forecast)
attach(df)
library(ggplot2)
library(dplyr)
library(tidyr)
p <- barplot(df$Confirmed, 
        main = "States&Ut Vs Confirmed Cases",
        xlab = "State.UnionTerritory",
        ylab = "Confirmed",
        names = df$State.UnionTerritory,
        col = "chocolate",
        border = "red")


function(input, output, session) {
  
  output$oconf <- renderText({
    d<-df[df$Date==input$dt1 & df$State.UnionTerritory==input$state,]
    paste(d$Confirmed)
    
  })
  
  output$mydates<-renderText({
    input$date1})
  
  output$ocur <- renderText({
    d<-df[df$Date==input$dt1 & df$State.UnionTerritory==input$state,]
    paste(d$Cured)
  })
  
  output$odet <- renderText({
    d<-df[df$Date==input$dt1 & df$State.UnionTerritory==input$state,]
    paste(d$Deaths)
  })
  
  output$plot <- renderPlot({
    if (input$plotType=='b'){
      barplot(df$Confirmed, 
              main = "States&Ut Vs Confirmed Cases",
              xlab = "State.UnionTerritory",
              ylab = "Confirmed",
              names = df$State.UnionTerritory,
              col = "chocolate",
              border = "red")
      
    } else {
      info_cov_india1<-arrange(df,Date)%>%group_by(Date)%>% 
        summarize(cured=sum(Cured),deaths=sum(Deaths),case=sum(Confirmed))
      info_cov_india1
      
      JJ<-ggplot(info_cov_india1,aes(x=Date))+
        geom_line(aes(y=case,color="Cases"), size=1.5)+ 
        geom_line(aes(y=deaths,color="Death"), size=1.5)+ 
        geom_line(aes(y=cured,color="Recovered"), size=1.5)+
        theme_bw()+ylab("Total Count")+xlab("Period")+ 
        labs(title="Cumulative Count of Covid19 cases, Recovered and Deaths",color = "Legend")+
        scale_color_manual(values = c("orange","red","blue"))
      
      JJ
      
    }
  })
  
  
  
  
  output$table <- DT::renderDataTable(
    df
  )
  
  output$plot1<-renderPlot({
    x<-input$sl1
    x
    fit <- auto.arima(df$Confirmed,)
    forecastedValues <- forecast(fit, x)
    plot(forecastedValues, main = "Graph with forecasting", 
         col.main = "darkgreen")
  }) 
}