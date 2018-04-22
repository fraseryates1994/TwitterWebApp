<%-- 
    Document   : gaPage
    Created on : 17-Mar-2018, 03:06:47
    Author     : Fraser
--%>

<%@page import="com.model.Results, java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Genetic Algorithm</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <style>
            /* Remove the navbar's default margin-bottom and rounded borders */ 
            .navbar {
                margin-bottom: 0;
                border-radius: 0;
            }

            /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
            .row.content {height: 450px}

            /* Set gray background color and 100% height */
            .sidenav {
                padding-top: 20px;
                background-color: #f1f1f1;
                height: 100%;
            }

            /* Set black background color, white text and some padding */
            footer {
                background-color: #555;
                color: white;
                padding: 15px;
            }

            /* On small screens, set height to 'auto' for sidenav and grid */
            @media screen and (max-width: 767px) {
                .sidenav {
                    height: auto;
                    padding: 15px;
                }
                .row.content {height:auto;} 
            }

            .button.small-btn {
                width: 100px;
                height: 10px;
                margin:10px
            }

        </style>
    </head>

    <body>
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>                        
                    </button>
                    <a class="navbar-brand" href="index.html">Twitter App</a>
                </div>
        </nav>

        <div class="container">
            <h1>GA</h1>
            <h2>Results</h2>
            <%   if (null != request.getAttribute("results")) {

                    ArrayList<Results> results = (ArrayList<Results>) request.getAttribute("results");

                    for (int i = 0; i != results.size(); ++i) {
                        out.println("Rule Base " + i + "<br/>");
                        out.println("Fitness = " + results.get(i).getFitness() + "Mutation Rate = " + results.get(i).getMutationRate() + "Population Size = " + results.get(i).getPopulationSize() + "<br/>");
                        out.println(results.get(i).getRuleBase().replaceAll("(\r\n|\n)", "<br />"));
                    }
                }
            %>

        </div>

        <footer class="container-fluid text-center">
            <p>Fraser Yates 15024481</p>
        </footer>
    </body>
</html>
