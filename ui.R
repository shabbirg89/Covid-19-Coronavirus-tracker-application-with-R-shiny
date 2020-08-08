df <- read.csv("C:/Users/sgove/OneDrive/Documents/Test/covid_19_india.csv")
df$Date <- as.Date(df$Date,format = "%d/%m/%y")
library(shiny)
library(markdown)
library(dplyr)



navbarPage("Navbar",
           navbarMenu("Home",
                      tabPanel("About",
                               headerPanel(strong("Covid-19 Tracker Application")),
                               fluidRow(
                                 column(6,
                                        h4(p(
                                          "This Rshiny Application is used to check the",
                                          "spread of Covid-19 throughout the nation through predictive analytics.",
                                          "Check it out for acccurate prediction",
                                          "& be safe."
                                        ))
                                 ),
                                 column(3,
                                        img(src='myImage.jpg',align = "bottom"
                                            
                                        )
                                 )
                               )
                               
                      ),
                      tabPanel("Table",
                               DT::dataTableOutput("table")
                      ),
                      tabPanel("Statewise data",
                               headerPanel("Enter the Date & select a State"),
                               sidebarPanel(
                                 dateInput("dt1","Date: ",
                                           min = "2020-01-01",
                                           max = "2020-05-26"),
                                 selectInput("state", "STATE:",choices = unique(df$State.UnionTerritory)),
                               ),
                               mainPanel(
                                 h3("Confirmed Case :",textOutput("oconf"),style="color:orange"),
                                 h3("Cured Case :",textOutput("ocur"),style="color:blue"),
                                 h3("Death Case :",textOutput("odet"),style="color:red")
                               )
                               
                      )
                      
           ),
           tabPanel("EDA",
                    sidebarLayout(
                      sidebarPanel(
                        radioButtons("plotType", "Plot type",
                                     c("Barplot"="b", "Line"="l")
                        )
                      ),
                      mainPanel(
                        plotOutput("plot")
                      )
                    )
                    
           ),
           tabPanel("Predictive Analysis",
                    pageWithSidebar(
                      headerPanel("Case's Increased Estimation"),
                      sidebarPanel(
                        sliderInput('sl1','No of Days',value = 5,min=0,max=10,step=1)
                      ),
                      mainPanel(
                        plotOutput('plot1')
                      )
                      
                    )
           )
           
)
