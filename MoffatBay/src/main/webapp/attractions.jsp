<%@ taglib prefix = "navbar" uri = "/WEB-INF/tlds/NavigationBarTld.tld" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Moffat Bay Resort</title>
  <link rel="stylesheet" href="styles.css">

  <style>
    div.scroll-container {
      background-color: #333;
      overflow: auto;
      white-space: nowrap;
      padding: 10px;
    }

    div.scroll-container img {
      padding: 10px;
    }

    .image-container {
      position: relative;
      width: 450px;
      height: 450px;
      overflow: hidden;
    }

    .image {
      height: auto;
      display: block;
      object-fit: cover;
    }

    .overlay-text {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(250, 250, 250, 0.6);
      color: black;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      text-align: center;
      padding: 20px;
      box-sizing: border-box;
      opacity: 0;
      transition: opacity 0.4s ease;
    }

    .image-container:hover .overlay-text {
      opacity: 1;
    }
  </style>
</head>
<body>
  <header>
    <navbar:NavigationBar />
  </header>

  <div class="title-img-container">
    <figure class="span-fig"><span>
      <img src="images/sunhands.png" alt="sunset hands" class="title-img" height="250">
        <figcaption style="text-align: center">Image from <a href="https://www.vecteezy.com/photo/47997008-hands-forming-heart-sunset-background">Vecteezy</a></figcaption>
      </span></figure>
  </div>
  <br>
  <h1 style="text-align: center;">Things To Do</h1>
  <p style="text-align: center;">From our Moffat Bay Marina, Moffat Bay Boardwalk, and a location near local attractions,
  <br>discover something for everyone at our relaxing lodge.</p>
  <br><hr><br>

  <div class="layout-container">
    <div class="row row-2-col" style="background-color: white;">
      <div class="col" style="display: flex;">
        <figure>
          <img src="images/marina-overview.png" alt="Marina Overview" style="max-width: 450px; height: auto;">
          <figcaption>Image from
            <a href="https://dbyhmarina.com/">Discover Bay Marina</a>
          </figcaption>
        </figure>
      </div>


    <div class="col" style="text-align: center;">
      <h3>Moffat Bay Marina</h3>
      <p>The signature marina is situated on Joviedsa Island, conveniently located near the Moffat Bay Lodge.
        Come moor your boat near to the lodge for easy accessibility during your stay.
        Slips of 26, 40, and 50 feet (7.9, 12.2, and 15.2 meters) are available, so you can reserve a spot no matter the length of your vessel.
      </p>
      <figure>
        <figcaption><strong>Marina Hours</strong></figcaption>
        <ul>
          <li>Monday - Friday: 9am - 6pm</li>
          <li>Saturday - Sunday: 8am - 10pm</li>
        </ul>
      </figure>
      <div class="col-buttons">
        <button class="button">Visit the Marina</button>
        <button class="button">Reserve a Slip</button>
      </div>
    </div>
  </div>


  <div class="row row-2-col" style="background-color: white;">
    <div class="col" style="text-align: center;">
      <h3>Joviedsa Island Grill</h3>
      <p>Located beside the lodge, our Island Grill pairs locally sourced seafood and spices with premium
      beef and wine grown right in the heart of Washington State. And with a sweeping view of the Salish Sea,
      Joviedsa Island Grill is the destination for special occasions worth lingering over.</p>
      <button class="button">Explore the Grill</button>
    </div>

    <div class="col">
      <figure class="img-fig">
        <img src="images/rainydining.png" alt="view of dining" style="max-width: 450px; height: auto;">
        <figcaption>Image from
          <a href="https://www.gotorainylake.com/dining">Dining on Rainy Lake</a></figcaption>
      </figure>
    </div>
  </div>

    <div class="row row-2-col" style="background-color: white;">
      <div class="col" style="display: flex;">
        <figure>
          <img src="images/hillhike.png" alt="Hill Overview" style="max-width: 450px; height: auto;">
          <figcaption>Image from
            <a href="https://www.visitsanjuans.com/hiking-san-juan-island">Visit San Juans</a>
          </figcaption>
        </figure>
      </div>

      <div class="col" style="text-align: center;">
        <h3>Serenity on the Hike</h3>
        <p>Enjoy a hike along one of the many nearby walking trails and take in the scenery that Moffat Bay has to offer.
          Several trails are available for you to experience a variety of sights while you enjoy Joviedsa Island&#39s natural beauty.
          No matter which path you walk, you are always guaranteed a fantastic adventure unlike any other.
        </p>
      </div>
    </div>
  </div>

<br><br><hr><br><br>

  <h2 style="text-align: center;">Extraordinary Experiences</h2>
  <p style="text-align: center;">There's always more to discover at the Moffat Bay Lodge.
    <br>The lodge always comes alive with special experiences that invite you to connect, celebrate, and make memories.
    <br>From kayaking with orcas, to scuba diving, to seasonal events, family activities, and unique gatherings.
    <br>Explore what's happening during your stay.
  </p>


  <div class="layout-container-img">
    <div class="row row-3-col">
      <div class="col" style="margin: 0; padding: 0;">
        <div class="image-container">
          <img src="images/kayaking.png" alt="Kayaking" class="image" width="450" height="450">
          <div class="overlay-text">
            <h3>Kayaking</h3>
            <p>Take in Moffat Bay's natural wonder from the water on a kayaking excursion.
              Experience the island's scenery from the perspective of the waters that form its home,
              and enjoy up close views of sights that are unreachable by foot.
              Guides are available to help even kayakers with no experience to enjoy the local waters.
            <br>Image from <a href="https://destinationlesstravel.com/things-to-do-on-the-san-juan-islands-washington/">Destinationless Travel</a>
            </p>
          </div>
        </div>
      </div>
      <div class="col" style="margin: 0; padding: 0;">
        <div class="image-container">
          <img src="images/scuba.png" alt="Scuba Diving" class="image" width="450" height="450">
          <div class="overlay-text">
            <h3>Scuba Diving</h3>
            <p>Swim alongside the creatures of the sea in this scuba diving adventure, where you can witness the many
              coral reefs and hidden treasures. Whether you are a pro or a beginner, we'll make sure you have
              experience of a lifetime.
              <br>Image from <a href="https://www.yelp.com/search?find_desc=Scuba+Diving&find_loc=San+Juan+County%2C+WA">Yelp</a>
            </p>
          </div>
        </div>
      </div>
      <div class="col" style="margin: 0; padding: 0;">
        <div class="image-container">
          <img src="images/whalewatch.png" alt="Whale Watching" class="image" width="450" height="450">
          <div class="overlay-text">
            <h3>Whale Watching</h3>
            <p>
              Witness the mighty orcas roaming Joviedsa Island. You can always take family, friends, or colleagues
              on a whale watch right before a big day. Our experienced guides will show you how to spot the orcas
              and how to find them in the wild.
              <br>Image from <a href="https://www.visitskagitvalley.com/discover/outer-island-excursions/">Skagit Valley</a>
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>


  <br><br><hr><br><br>

<h2 style="text-align: center;">Explore the San Juan Islands</h2>
<p style="text-align: center;">We are at the center of the archipelago. Everything is just a 30-minute ferry ride away.
  <br>Witness the wildlife of San Juan Island, visit the Orcas Island scenic byway, shop for antiques or fashions,
  <br>or spend a day touring dramatic landscapes of the islands.
  <br>Images from <a href="https://www.lakedale.com/blog/11-shops-to-visit-in-friday-harbor/">Lakedale</a> and
  <a href="https://www.visitsanjuans.com/history-arts-education">Visit San Juan</a>
</p>
<br>

<div class="scroll-container">
  <a href="https://www.lakedale.com/blog/11-shops-to-visit-in-friday-harbor/">
  <img src="images/fridayharbor.png" alt="Friday Harbor" width="600" height="500">
  </a>
  <a href="https://www.lakedale.com/blog/the-best-time-to-see-orcas-in-the-san-juan-islands/">
  <img src="images/orcasjump.png" alt="Orcas Jump" width="600" height="500">
  </a>
  <a href="https://www.visitsanjuans.com/san-juan-islands-scenic-byway">
  <img src="images/orcasislandbyway.png" alt="Byway Bicycle" width="600" height="500">
  </a>
  <a href="https://www.visitsanjuans.com/history-arts-education">
  <img src="images/sanjuanart.png" alt="Scullptures" width="600" height="500">
  </a>
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
      <p><a class="foota" href="reservation.jsp">Book a Room</a></p>
      <p><a class="foota" href="contact.jsp">Contact Us</a></p>
    </div>
  </div>
  <div class="footer-line"></div>
  <p>© 2028 Moffat Bay, LLC. All rights reserved.</p>
</footer>
</body>
</html>