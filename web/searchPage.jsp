<%-- 
    Document   : search
    Created on : 17-Mar-2018, 03:06:02
    Author     : Fraser
--%>

<%@page import="java.util.List, twitter4j.*"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search</title>
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
            <h1>Demographics</h1>
            <p> 
                Use this page to search for a twitter account, view their most recent 10 statuses and display the demographics of the users who have replied. <br/>
                The demographics include:
            <ol>
                <li>Average number of followers of users</li>
                <li>User with the most followers</li>
                <li>Average number of friends of users</li>
                <li>User with the most friends</li>
                <li>Location</li>
                <li>Positive emoji information 😀 ❤</li>
                <li>Negative emoji information ☹ 😠</li>
                <li>Positive word information "Love" "Amazing!"</li>
                <li>Negative word information "Hate" "Boring!"</li>
                <li>Swear information "S!*T"</li>
                <li>Verified users</li>
                <li>'Favourite' replies</li>
            </ol>
            Notes:
            <ol>
                <li>This system does not gather reply to replies</li>
                <li>Only recent replies are gathered</li>
                <li>Not all locations can be collected because some users keep this information private</li>
            </ol>
        </p>

        Enter the name of a Twitter account:
        <form action="Search" method="post">
            <input type="text" name="searchInput" placeholder="hi">
            <button type="Submit" Value="searchTwitter" name="button" class='btn btn-success'>
                Search
            </button>
        </form>

        Searching for: 
        <%
            if (null != request.getAttribute("twitterUser")) {
                out.println(request.getAttribute("twitterUser"));
            } else if (null != request.getAttribute("error")) {
                out.println(request.getAttribute("error"));
            }
        %>

        <br/>

        <h2>Statuses</h2>
        <table>
            <thead>
                <tr>
                    <th scope="col">Username</th>
                    <th scope="col">Status</th>                   
                </tr>
            </thead>
            <tbody>
                <%   if (null != request.getAttribute("statuses")) {

                        List<Status> statuses = (List<Status>) request.getAttribute("statuses");

                        for (int i = 0; i != statuses.size(); ++i) {
                            out.println("<tr> <td> " + i + "</td> <td>" + statuses.get(i).getText() + "</td>  </tr>");
                        }
                    }
                %>
            </tbody>
        </table>

        <br/>

        <% if (null != request.getAttribute("statuses")) { %>
        <form action="Search" method="post">
            <select name="selectedStatus">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
                <option value="7">7</option>
                <option value="8">8</option>
                <option value="9">9</option>
            </select>
            <button type="Submit" value="selectStatus" name="button" class='btn btn-success'>
                Select ID
            </button>
        </form>
        <% }%>

        <br/>


        <%
        if (null != request.getAttribute("avgFriends")) { %>
        <h2>Average Friends</h2>
        Average friends = 
        <%
                out.println(request.getAttribute("avgFriends"));
            }
            if (null != request.getAttribute("mostFriends")) {
        %>
        <br/> User with the most friends: 
        <%
                User mostFriends = (User) request.getAttribute("mostFriends");
                out.println("<td>" + "<a href=\"" + mostFriends.getURL() + "\">" + mostFriends.getScreenName() + "</a>");
            }
        %>

    </a>
    <br/>





    <%
    if (null != request.getAttribute("avgFollowers")) { %>
    <h2>Average Followers</h2>
    Average followers = 
    <%
            out.println(request.getAttribute("avgFollowers"));
        }
        if (null != request.getAttribute("mostFollowers")) {
    %>
    <br> User with the most followers: 
    <%
            User mostFollowers = (User) request.getAttribute("mostFollowers");
            out.println("<td>" + "<a href=\"" + mostFollowers.getURL() + "\">" + mostFollowers.getScreenName() + "</a>");
        }
    %>


    <%
    if (null != request.getAttribute("positiveEmoji")) { %>
    <h2>Positive Emoticons</h2>
    Total = 
    <%
        List<Status> positiveEmojiReplies = (List<Status>) request.getAttribute("positiveEmoji");
        out.println(positiveEmojiReplies.size());
    %>
    <table>
        <thead>
            <tr>
                <th scope="col">Username</th>
                <th scope="col">Status</th>                   
            </tr>
        </thead>
        <tbody>
            <%
                for (int i = 0; i != positiveEmojiReplies.size(); ++i) {
                    out.println("<tr> <td> " + positiveEmojiReplies.get(i).getUser().getScreenName() + "</td> <td>" + positiveEmojiReplies.get(i).getText() + "</td>  </tr>");
                }

            %>
        </tbody>
    </table>
    <% }%>



    <%
    if (null != request.getAttribute("negativeEmoji")) {%>
    <h2>Negative Emoticons</h2>
    Total = 
    <%
        List<Status> negativeEmojiReplies = (List<Status>) request.getAttribute("negativeEmoji");
        out.println(negativeEmojiReplies.size());
    %>
    <table>
        <thead>
            <tr>
                <th scope="col">Username</th>
                <th scope="col">Status</th>                   
            </tr>
        </thead>
        <tbody>
            <%
                for (int i = 0; i != negativeEmojiReplies.size(); ++i) {
                    out.println("<tr> <td> " + negativeEmojiReplies.get(i).getUser().getScreenName() + "</td> <td>" + negativeEmojiReplies.get(i).getText() + "</td>  </tr>");
                }

            %>
        </tbody>
    </table>
    <% }%>


    <%
    if (null != request.getAttribute("positiveWord")) {%>
    <h2>Positive Words</h2>
    total = 
    <%
        List<Status> positiveWordReplies = (List<Status>) request.getAttribute("positiveWord");
        out.println(positiveWordReplies.size());
    %>
    <table>
        <thead>
            <tr>
                <th scope="col">Username</th>
                <th scope="col">Status</th>                   
            </tr>
        </thead>
        <tbody>
            <%
                for (int i = 0; i != positiveWordReplies.size(); ++i) {
                    out.println("<tr> <td> " + positiveWordReplies.get(i).getUser().getScreenName() + "</td> <td>" + positiveWordReplies.get(i).getText() + "</td>  </tr>");
                }

            %>
        </tbody>
    </table>
    <% }%>


    <%
    if (null != request.getAttribute("negativeWord")) {%>
    <h2>Negative Words</h2>
    total = 
    <%
        List<Status> negativeWordReplies = (List<Status>) request.getAttribute("negativeWord");
        out.println(negativeWordReplies.size());
    %>
    <table>
        <thead>
            <tr>
                <th scope="col">Username</th>
                <th scope="col">Status</th>                   
            </tr>
        </thead>
        <tbody>
            <%
                for (int i = 0; i != negativeWordReplies.size(); ++i) {
                    out.println("<tr> <td> " + negativeWordReplies.get(i).getUser().getScreenName() + "</td> <td>" + negativeWordReplies.get(i).getText() + "</td>  </tr>");
                }

            %>
        </tbody>
    </table>
    <% }%>


    <%
    if (null != request.getAttribute("swear")) {%>
    <h2>Swear Words</h2>
    total = 
    <%
        List<Status> swearReplies = (List<Status>) request.getAttribute("swear");
        out.println(swearReplies.size());
    %>
    <table>
        <thead>
            <tr>
                <th scope="col">Username</th>
                <th scope="col">Status</th>                   
            </tr>
        </thead>
        <tbody>
            <%
                for (int i = 0; i != swearReplies.size(); ++i) {
                    out.println("<tr> <td> " + swearReplies.get(i).getUser().getScreenName() + "</td> <td>" + swearReplies.get(i).getText() + "</td>  </tr>");
                }

            %>
        </tbody>
    </table>
    <% }%>


    <%
    if (null != request.getAttribute("verified")) {%>
    <h2>Verified Users</h2>
    total = 
    <%
        List<Status> verifiedReplies = (List<Status>) request.getAttribute("verified");
        out.println(verifiedReplies.size());
    %>
    <table>
        <thead>
            <tr>
                <th scope="col">Username</th>
                <th scope="col">Status</th>                   
            </tr>
        </thead>
        <tbody>
            <%
                for (int i = 0; i != verifiedReplies.size(); ++i) {
                    out.println("<tr> <td>" + "<a href=\"" + verifiedReplies.get(i).getUser().getURL() + "\">" + verifiedReplies.get(i).getUser().getScreenName() + "</a>" + "</td>  <td>" + verifiedReplies.get(i).getText() + "</td>  </tr>");
                }

            %>
        </tbody>
    </table>
    <% }%>


    <%
    if (null != request.getAttribute("favourite")) {%>
    <h2>Favourite'd Replies</h2>
    <%
        if (null != request.getAttribute("mostFavourite")) {
            Status favourite = (Status) request.getAttribute("mostFavourite");
    %>
    Most favourite'd Comment = 
    <%
        out.println(favourite.getText());
    %>
    <br/>Username =
    <%
            out.println(favourite.getUser().getScreenName());
        }
    %>
    <br/>
    total = 
    <%
        List<Status> favouriteReplies = (List<Status>) request.getAttribute("favourite");
        out.println(favouriteReplies.size());
    %>
    <table>
        <thead>
            <tr>
                <th scope="col">Username</th>
                <th scope="col">Status</th>                   
            </tr>
        </thead>
        <tbody>
            <%
                for (int i = 0; i != favouriteReplies.size(); ++i) {
                    out.println("<tr> <td> " + favouriteReplies.get(i).getUser().getScreenName() + "</td> <td>" + favouriteReplies.get(i).getText() + "</td>  </tr>");
                }

            %>
        </tbody>
    </table>
    <%  }
    %>

</div>

<footer class="container-fluid text-center">
    <p>Fraser Yates 15024481</p>
</footer>
</body>
</html>

