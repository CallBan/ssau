package com.ssau.simplewebapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "GameServlet", urlPatterns = {"/game"})
public class GameServlet extends HttpServlet {

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {

    String minParam = request.getParameter("min");
    String maxParam = request.getParameter("max");
    String answer = request.getParameter("answer");

    HttpSession session = request.getSession(true);

    try {
      if (minParam != null && maxParam != null) {
        int min = Integer.parseInt(minParam);
        int max = Integer.parseInt(maxParam);

        if (min > max) {
          request.getRequestDispatcher("error.jsp").forward(request, response);
          return;
        }

        session.setAttribute("min", min);
        session.setAttribute("max", max);

        int guess = (min + max) / 2;
        session.setAttribute("guess", guess);

        request.getRequestDispatcher("game.jsp").forward(request, response);

      } else if (answer != null) {

        Integer min = (Integer) session.getAttribute("min");
        Integer max = (Integer) session.getAttribute("max");
        Integer guess = (Integer) session.getAttribute("guess");

        if (min == null || max == null || guess == null) {
          request.getRequestDispatcher("error.jsp").forward(request, response);
          return;
        }

        switch (answer) {
          case "bigger":
            min = guess + 1;
            break;
          case "smaller":
            max = guess - 1;
            break;
          case "correct":
            request.getRequestDispatcher("win.jsp").forward(request, response);
            return;
        }

        session.setAttribute("min", min);
        session.setAttribute("max", max);

        if (min > max) {
          request.getRequestDispatcher("cheat.jsp").forward(request, response);
          return;
        }

        int newGuess = (min + max) / 2;
        session.setAttribute("guess", newGuess);

        request.getRequestDispatcher("game.jsp").forward(request, response);

      } else {
        request.getRequestDispatcher("error.jsp").forward(request, response);
      }

    } catch (NumberFormatException e) {
      request.getRequestDispatcher("error.jsp").forward(request, response);
    }
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.sendRedirect("index.jsp");
  }
}