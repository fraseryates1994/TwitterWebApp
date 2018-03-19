/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.web;

import com.model.Demographics;
import java.io.IOException;
import java.io.PrintWriter;
import com.model.TwitterWrapper;
import java.util.ArrayList;
import twitter4j.*;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Fraser
 */
public class SearchServlet extends HttpServlet {

    List<Status> statuses = new ArrayList();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String button = request.getParameter("button"); // Get value from button
        switch (button) {
            case "searchTwitter":
                String twitterUser = request.getParameter("searchInput");
                request.setAttribute("twitterUser", twitterUser);

                TwitterWrapper tw = new TwitterWrapper();
                statuses = tw.getStatuses(twitterUser);

                request.setAttribute("statuses", statuses);

                RequestDispatcher view = request.getRequestDispatcher("searchPage.jsp");
                view.forward(request, response);
                break;
            case "selectStatus":
                int replyIndex = Integer.parseInt(request.getParameter("selectedStatus"));

                request.setAttribute("statuses", statuses);

                // get replies from status and get demogrpahics
                TwitterWrapper tw2 = new TwitterWrapper();
                ArrayList replies = tw2.getDiscussion2(statuses.get(replyIndex));

                if (replies.isEmpty()) {
                    request.setAttribute("error", "No replies");
                    RequestDispatcher view3 = request.getRequestDispatcher("searchPage.jsp");
                    view3.forward(request, response);
                }

                // set demogrpahics
                Demographics dem = new Demographics();
                dem.setDemographics(replies);

                request.setAttribute("avgFriends", dem.getTotalFriends() / replies.size());
                request.setAttribute("mostFriends", dem.getMostFriends());
                request.setAttribute("avgFollowers", dem.getTotalFollowers() / replies.size());
                request.setAttribute("mostFollowers", dem.getMostFollowers());
                request.setAttribute("location", dem.getLocationReplies());
                request.setAttribute("positiveEmoji", dem.getPositiveEmojiReplies());
                request.setAttribute("negativeEmoji", dem.getNegativeEmojiReplies());
                request.setAttribute("positiveWord", dem.getPositiveWordReplies());
                request.setAttribute("negativeWord", dem.getNegativeWordReplies());
                request.setAttribute("swear", dem.getSwearReplies());
                request.setAttribute("verified", dem.getVerifiedReplies());
                request.setAttribute("favourite", dem.getFavouriteReplies());
                request.setAttribute("mostFavourite", dem.getMostFavourited());

                // refresh page
                RequestDispatcher view2 = request.getRequestDispatcher("searchPage.jsp");
                view2.forward(request, response);
                break;
            default:
                break;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public static String cleanText(String text) {
        text = text.replace("\n", "\\n");
        text = text.replace("\t", "\\t");

        return text;
    }

}
