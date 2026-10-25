<%@ taglib prefix = "navbar" uri = "/WEB-INF/tlds/NavigationBarTld.tld" %><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <title>Moffat Bay Resort</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        .title-img-container{
            margin: 0;
            padding: 0;
            width: 100%;
        }
        .span-fig {
            margin: 0;
            width: 100%;
        }
        figure span {
            display: block;
            width: 100%;
        }
        .title-img {
            display: block;
            width: 100%;
            height: auto;
        }
        p.title-support {
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
        }
        .layout-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }
        .row {
            display: flex;
            justify-content: center;
            width: 100%;
            gap: 20px;
        }
        .col{
            padding: 30px 20px;
            color: #333;
        }
        .row-2-col {
            flex: 1;
        }
        .row-3-col {
            flex: 1;
        }
        h2 {
            text-align: center;
        }
    </style>
</head>
<body>
    <header>
        <navbar:NavigationBar />
    </header>

<div class="title-img-container">
    <figure class="span-fig"><span>
    <img src="images/lodgeview.png" alt="Lake view lodge" class="title-img">
        <figcaption style="text-align: center">Image from <a href="https://www.visitsanjuans.com/stay-san-juan-island">San Juan Islands Visitors Bureau</a></figcaption>
    </span></figure>
</div>

<br><br>
<h1 style="text-align: center;">About Us</h1>
<p class="title-support">We are a luxury lodge located in the heart of Joviedsa Island, offering a unique and comfortable stay for our guests.
    Our hotel is designed to provide a comfortable and relaxing environment, with a range of amenities and services to suit every taste and preference.</p>

<br><hr><br>

<div class="layout-container">
    <div class="row row-2-col">
        <div class="col">
        <figure>
        <img src="images/earlyconst.png" alt="Early Construction" style="max-width: 450px; height: auto;">
            <figcaption>Image from
                <a href="https://unofficialnetworks.com/2024/10/04/tamarack-resort-mid-mountain-lodge-finally-set-to-open-after-getting-stalled-mid-construction-in-2008/">Unofficial Networks</a></figcaption>
            </figure>
        </div>

        <div class="col">
            <h3>Our Lodge</h3>
            <p>We are a company committed to your getaway trip.
            At Moffat Bay Lodge, our team provides excellent service in and outside the Lodge.
            Our hospitality staff will ensure the ultimate experience while our team of chefs,
            waiters, and housekeepers will take care of the rest.
            </p>
        </div>
    </div>


    <div class="row row-2-col">
        <div class="col" style="text-align: right;">
            <h3>Our Story</h3>
            <p>The lodge began construction in 2024, when Joviedsa Island was still untouched in its natural serenity.
            Through a grant by the San Juan Islands Chamber of Commerce, and with the support of the local community,
            the lodge is built to welcome the community closer to the awe and wonder of the natural habitat.</p>
        </div>

        <div class="col">
            <figure>
                <img src="images/preserve.png" alt="view of San Juan" style="max-width: 450px; height: auto;">
                <figcaption>Image from
                    <a href="https://www.visitsanjuans.com/account/upright-head-preserve">Visit San Juan</a></figcaption>
            </figure>
        </div>
    </div>


    <div class="row row-3-col">
        <div class="col">
            <h2>Our Staff</h2>
            <figure>
                <img src="images/staff.png" alt="Lake view staff" style="max-height: 300px; width: auto;">
                <figcaption>Image from
                    <a href="https://larsenbaylodge.com/lodging.html">Larson Bay Lodge</a></figcaption>
            </figure>
        </div>

        <div class="col">
            <h2>Our Home</h2>
            <figure>
                <img src="images/lodge.png" alt="Lake view lodge" style="max-height: 300px; width: auto;">
                <figcaption>Image from
                    <a href="https://www.vrbo.com/3373573">VRBO (Goose Bay Lodge)</a></figcaption>
            </figure>
        </div>
        <div class="col">
            <h2>Our Backyard</h2>
            <figure>
                <img src="images/aerialview.png" alt="Aerial view" style="max-height: 300px; width: auto;">
                <figcaption>Image from
                    <a href="https://www.alaskacollection.com/lodging/kenai-fjords-wilderness-lodge/experience/">Kenai Fjords Wilderness Lodge</a></figcaption>
            </figure>
        </div>
    </div>
</div>

<br><br>

<footer>
    <div class="footer-content">
        <div>
            <p><img src="images/logo.png" alt="Moffat Bay Logo" width="60px" style="vertical-align: middle;"><b>Moffat Bay Resort</b></p>
            <p>1234 Body of Water St</p>
            <p>Anytown, Anystate 12345</p>
            <p>(123) 456-7890</p>
        </div>
        <div style="text-align: right;">
            <p><b>Quick Links</b></p>
            <p><a class="foota" href="room.jsp">Book a Room</a></p>
            <p><a class="foota" href="#">Contact Us</a></p>
        </div>
    </div>
    <div class="footer-line"></div>
    <p>© 2028 Moffat Bay, LLC. All rights reserved.</p>
</footer>
</body>
</html>