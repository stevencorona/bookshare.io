# Bookshare.io

I'm moving to San Francisco and I need to get rid of my (200+) books. I want them to go to good homes.

**So I'm giving away all of my books for free**

This is an free, open-source application. You check out the [Demo](http://bookshare.io), or [read about the project on my blog](http://stevecorona.com/experiment-in-sharinghow-i-launched-bookshareio-in-a-week/).

(Update: All of my books got taken in < 24 hours!)

# Setup
This is a Rails 4 app, running on Heroku. It should be pretty simple to get started with just using the normal `git push heroku` flow.

* I -do- use the full text search features of Postgres, so this will not work w/ MySQL or Sqlite out of the box
* I use Mailgun for sending emails, Cloudinary for handling images, and Stripe for processing payments
* Shipment labels are generated with EasyPost

The application depends on the environmental variables—

    CLOUDINARY_URL
    STRIPE_PRIVATE_KEY
    STRIPE_PUBLIC_KEY
    SECRET_TOKEN
    GOOGLE_ANALYTICS_ID
    MAILGUN_API_KEY
    MAILGUN_SMTP_LOGIN
    MAILGUN_SMTP_PASSWORD
    MAILGUN_SMTP_PORT
    MAILGUN_SMTP_SERVER
    SECRET_KEY_BASE
    ADMIN_USERNAME
    ADMIN_PASSWORD

# How to Add books

    rails console
    app.post '/books', {"token"=>"",  "isbn"=>'0321700694'}


### MIT License
    
    The MIT License (MIT)

    Copyright (c) 2014 Steve Corona Inc.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
