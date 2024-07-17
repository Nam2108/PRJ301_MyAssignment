/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.servlet.Servlet;
import jakarta.servlet.http.HttpServlet;

/**
 *
 *
 */
public class ConfigurationHelper {
    public static int getCanvasW(HttpServlet current)
    {
        return Integer.parseInt(current.getServletContext().getInitParameter("canvasW"));
    }
    
    public static int getCanvasH(HttpServlet current)
    {
        return Integer.parseInt(current.getServletContext().getInitParameter("canvasH"));
    }
}
