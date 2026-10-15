<%@ taglib prefix = "navbar" uri = "WEB-INF/tlds/NavigationBarTld.tld" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">

    <title>Moffat Bay Resort</title>
    <link rel="stylesheet" href="styles.css">

    <style>
        .roomcontainer {
            max-width: 1000px;
            margin: 0 auto;
        }

        .room-option {
            display: grid;
            grid-template-columns: 190px minmax(0, 1fr);
            gap: 22px;
            padding: 22px;
            margin-bottom: 18px;
            background: #fff;
            border: 1px solid #dce1e7;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgb(0 0 0 / 4%);
        }

        .room-details {
            display: flex;
            flex: 1;
            flex-direction: column;
            min-width: 0;
            max-width: 100%;
            margin-left: auto;
        }

        .room-description {
            margin: 0 0 16px;
            color: black;
            font-size: 14px;
            line-height: 1.5;
        }

        .list-columns {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 18px;
        }

        .list-columns ul {
            margin: 0;
            padding-left: 20px;
            color: #59636f;
            font-size: 14px;
            line-height: 1.8;
        }

        .room-selection {
            display: flex;
            justify-content: flex-end;
            margin-top: auto;
        }

        .room-image {
            width: 250px;
            height: 200px;
            object-fit: cover;
            border-radius: 6px;
        }

        .select-button {
            min-width: 100px;
            padding: 10px 20px;
        }
    </style>

</head>
<body>
    <header>
        <navbar:NavigationBar />
    </header>

<h1 style="text-align: center">Book a Room</h1>

<div class = "form-container">
    <!-- Date Range Selection -->
    <div class = "form-column">
        <div class="form-group">
            <label for="start-date">Check In:</label>
            <input type="date" id="start-date" name="start_date" required>
        </div>
    </div>

    <div class = "form-column">
        <div class="form-group">
            <label for="end-date">Check Out:</label>
            <input type="date" id="end-date" name="end_date" required>
        </div>
    </div>

    <div class = "form-column">
        <div class="form-group">
            <label for="num1">How Many Rooms?</label>
            <input type="number" id="num1" name="num1" class="two-digit" min="1" max="99" placeholder="0" required>
        </div>
    </div>

    <div class = "form-column">
        <div class="form-group">
            <label for="num2">How Many Guests?</label>
            <input type="number" id="num2" name="num2" class="two-digit" min="1" max="99" placeholder="0" required>
        </div>
    </div>
</div>

<div class="roomcontainer">
    <section class = "room-option">
        <figure>
            <img class="room-image" src="doubleview.png" alt="room with two double beds">
            <figcaption>Image from <a href="https://www.hotelfigueroa.com/rooms-suites/two-double-beds/">Hotel Figueroa</a></figcaption>
        </figure>


        <div class = "room-details">
            <h2>2 Double Beds ($120/night)</h2>
            <p class="room-description">
                A simple and comfortable option for a relaxed getaway.
                <br>A refreshing choice for a relaxed outdoor getaway.</p>

            <div class="list-columns">
                <div>
                    <ul>
                        <li>Microwave</li>
                        <li>Workspace</li>
                    </ul>
                </div>

                <div>
                    <ul>
                        <li>Sleeps 2</li>
                    </ul>
                </div>
            </div>

            <div class="room-selection">
                <button type="button" class="select-button">Select</button>
            </div>
        </div>
    </section>

    <section class = "room-option">
        <figure>
            <img class="room-image" src="1queenview.png" alt="room with a queen bed">
            <figcaption>Image from <a href="https://lodgeatwhitefishlake.com/content/one-bedroom-suites/1c3dd881-9248-4dcd-87d9-9067a080e171">The Lodge at Whitefish Lake</a></figcaption>
        </figure>

        <div class = "room-details">
            <h2>1 Queen Bed ($135/night)</h2>
            <p class="room-description">
                Enjoy fresh air, scenic trails, and peaceful views in a beautiful mountain setting.
                <br>A refreshing choice for a relaxed outdoor getaway.</p>

            <div class="list-columns">
                <div>
                    <ul>
                        <li>Microwave</li>
                        <li>Workspace</li>
                    </ul>
                </div>

                <div>
                    <ul>
                        <li>Sleeps 2</li>
                    </ul>
                </div>
            </div>

            <div class="room-selection">
                <button type="button" class="select-button">Select</button>
            </div>
        </div>
    </section>

    <section class = "room-option">
        <figure>
            <img class="room-image" src="2queenview.png" alt="room with two queen beds">
            <figcaption>Image from <a href="https://www.theestesparkresort.com/accomodations/mountain-view-lakeside-double-queen">The Estes Park Resort & Spa</a></figcaption>
        </figure>

        <div class = "room-details">
            <h2>2 Queen Beds ($150/night)</h2>
            <p class="room-description">
                The best option for a family vacation, or a party.
                <br>Enjoy a relaxing room with a wide living area.
            </p>

            <div class="list-columns">
                <div>
                    <ul>
                        <li>Microwave</li>
                        <li>Wide Living Area</li>
                    </ul>
                </div>

                <div>
                    <ul>
                        <li>Sleeps 4</li>
                        <li>Sofa</li>
                    </ul>
                </div>
            </div>

            <div class="room-selection">
                <button type="button" class="select-button">Select</button>
            </div>
        </div>
    </section>

    <section class="room-option">
        <figure>
            <img class="room-image" src="kingview.png" alt="room with two double beds">
            <figcaption>Image from <a href="https://www.riverhouse.com/stay/one-bedroom-suites/">Riverhouse Lodge</a></figcaption>
        </figure>

        <div class="room-details">
            <h2>1 King Bed ($160/night)</h2>
            <p class="room-description">
                A spacious room with a breathtaking view of the mountain lake.
                <br>A refreshing choice for a luxurious outdoor getaway.</p>

            <div class="list-columns">
                <div>
                    <ul>
                        <li>Microwave</li>
                        <li>Living Area</li>
                    </ul>
                </div>

                <div>
                    <ul>
                        <li>Sleeps 2</li>
                        <li>Sectional</li>
                    </ul>
                </div>
            </div>

            <div class="room-selection">
                <button type="button" class="select-button">Select</button>
            </div>
        </div>
    </section>

    <br><br>
    <button type="submit" style="text-align: center">Submit</button>
</div>

<br><br>
<footer>
    <div class="footer-content">
        <div>
            <p><img src="logo.png" alt="Moffat Bay Logo" width="60px" style="vertical-align: middle;"><b>Moffat Bay Resort</b></p>
            <p>1234 Body of Water St</p>
            <p>Anytown, Anystate 12345</p>
            <p>(123) 456-7890</p>
        </div>
        <div style="text-align: right;">
            <p><b>Quick Links</b></p>
            <p><a class="foota" href="reservation.jsp">Book a Room</a></p>
            <p><a class="foota" href="#">Contact Us</a></p>
        </div>
    </div>
    <div class="footer-line"></div>
    <p>© 2028 Moffat Bay, LLC. All rights reserved.</p>
</footer>

</body>
</html>