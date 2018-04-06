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
    </head>
    <body>
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

    </body>
</html>
