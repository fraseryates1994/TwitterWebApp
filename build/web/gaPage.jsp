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
            <h1>Data Mining</h1>
            <p1>
                Below shows an example of an evolved rule base which aims to classify replies to 10 tweets:
            </p1>
            <br/>
            <p2>
                <b>Rule 1</b>
                <br/>
                IF Kim Kardashian posts about her new baby Chicago AND IF followers is in the range of 0 – 10 AND IF reply is not favourited AND IF friends is in the range of 100 – 300 AND IF location is in Africa AND IF comment does not contain a positive word AND IF comment does not contain a negative word AND IF comment does not contain a positive emoji,
                <br/>
                <mark>THEN comment is neutral</mark>
                <br/>
                <b>Rule 2</b>
                <br/>
                IF Kim Kardashian posts about her new baby Chicago AND If followers is in the range of 11 – 100 AND IF reply is not favourited AND IF friends is in the range of 10 – 100 AND IF location is in Asia AND IF comment does not contains a swear word AND IF comment does not contain a negative word AND IF comment does not contain a positive emoji AND IF comment does not contain a negative emoji,
                <br/>
                <mark>THEN comment is negative</mark>
                <br/>
                <b>Rule 3</b>
                <br/>
                IF Kim Kardashian posts about her new baby Chicago AND IF reply is not favourited AND IF friends is 300+ AND IF comment contains a negative word AND IF comment does not contain a positive emoji AND IF comment does not contain a negative emoji,
                <br/>
                <mark>THEN comment is neutral</mark>
                <br/>
                <b>Rule 4</b>
                <br/>
                If anything else
                <br/>
                <mark>THEN comment is positive</mark>
            </p2>

            <h2>Requests</h2>
            <h4>Leave a Request:</h4>
            <form action="GA" method="post">
                <div class="form-group">
                    Name:
                    <input type="text" name="userName" class="form-control" required>
                    Email:
                    <input type="text" name="userEmail" class="form-control" required>
                    Request:
                    <textarea class="form-control" rows="3" name="userInput" required></textarea>
                </div>
                <button type="submit" Value="userRequest" name="button" class="btn btn-success">
                    Submit
                </button>
            </form>

            <br/>
            <%
                if (null != request.getAttribute("complete")) {
                    out.println(request.getAttribute("complete"));
                }
            %>

            <h2>Previous Results</h2>
            Click the button  below to view previous results:
            <br/>
            <form action="GA" method="post">
                <button type="submit" Value="previousResults" name="button" class="btn btn-success">
                    Here
                </button>
            </form>
            <%   if (null != request.getAttribute("results")) {
                    int j = 0;
                    ArrayList<Results> results = (ArrayList<Results>) request.getAttribute("results");

                    for (int i = 0; i != results.size(); ++i) {
                        j = i + 1;
                        out.println("<b>Result Number " + j + "</b><br/>");
                        out.println("Fitness = " + results.get(i).getFitness() + " Mutation Rate = " + results.get(i).getMutationRate() + " Population Size = " + results.get(i).getPopulationSize() + "<br/>");
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
