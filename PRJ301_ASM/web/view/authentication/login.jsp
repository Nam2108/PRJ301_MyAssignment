

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        
    </head>
    <body>
        <div class="body-content">
            <h2 class="login-title">Welcome to FPT University</h2>
            <img src="img/Logo.jpg" alt="">
            <form action="login" method="post">
                <h3 style="color: red">${mess}</h3>
                <input type="text" name="username" placeholder="Fpt email" required=""> <br />
                <input type="password" name="password" placeholder="Password" required=""> <br />
                <div class="remember-account">
                    <input type="checkbox" name="remember" value="remember">
                    <label for="remember">Remember me</label>
                </div>
                <div> 
                    <select name="Campus" id="">
                        <option value="1">HaNoi</option>
                        <option value="2">DaNang</option>
                        <option value="3">HCM</option>
                        <option value="4">CanTho</option>
                    </select>
                    <a href="home.html">Forgot the password</a>
                </div>
                <button>Login</button>
            </form>
        </div>
    </body>
</html>
