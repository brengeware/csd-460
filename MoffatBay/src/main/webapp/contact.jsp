<!-- Brennan Cheatwood, Anthony Nguyen, and Daniel Preller, 27 October 2026, Assignment 8
Static JSP page for lodge contact info -->
<%@ taglib prefix = "navbar" uri = "/WEB-INF/tlds/NavigationBarTld.tld" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <title>Moffat Bay Resort</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <navbar:NavigationBar />
    </header>

    <br><br>

    <h1 style="text-align: center">Contact Us</h1>
    <br><hr><br>

    <div class="contact-container">
        <div class = "contact-column" style="background-color: #f9f9f9; margin: -20px; padding: 20px;">
            <form action="contact.jsp" method="post" style="text-align: center; max-width: 422px;">
            <!-- Because there is no real lodge to contact, the contact form is non-functional -->
                <div class="form-group">
                    <h2>Questions?</h2>
                    <p>Please fill out the form below to get in touch with us.</p>
                    <br>
                    <div class = "form-group">
                        <input type = text tabindex = "1" id = fullName name = fullName placeholder="Name" autofocus>
                    </div>

                    <div class = "form-group">
                        <input type = email tabindex = "2" id = emailContact name = emailContact placeholder="Email">
                    </div>

                    <div class = "form-group">
                        <input type = tel tabindex = "3" id = phoneContact name = phoneContact placeholder="Phone Number">
                    </div>

                    <div class = "form-group">
                        <textarea tabindex = "4" id = message name = message value = message rows="4" cols="50" placeholder="Message"></textarea>
                    </div>

                    <div class = "form-group">
                        <input type = button tabindex = "5" value = "Send">
                    </div>
                </div>
            </form>
        </div>

        <div class = "contact-column">
            <div class="form-group">
                <h2>Contact Info</h2>

                <p>1234 Body of Water St, Anytown, Anystate 12345
                <br>(123) 456-7890
                <br>com@example.demo</p>

            </div>
            <div class="form-group">
                <img src="images/mapview.png" alt="Map of Moffat Bay Resort" width="375" height="375">
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2028 Moffat Bay, LLC. All rights reserved.</p>
    </footer>
</body>
</html>