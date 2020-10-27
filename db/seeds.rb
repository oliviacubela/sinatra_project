User.destroy_all 

olivia = User.create(username: "Olivia", email: "olivia@olivia.com", image_url: "https://i.pinimg.com/236x/6f/88/b0/6f88b07047e7d12ab56adb7ba33353e2--plane-photography-sky-view.jpg", bio: "Will Work For Travel", password: "pw")

gigi = User.create(username: "Gigi", email: "gigi@gigihadid.com", image_url: "https://www.etonline.com/sites/default/files/styles/max_970x546/public/images/2020-06/gigi-hadid-1280.jpg?h=e8c4d158&itok=i5LGovZI", bio: "International Jetsetter", password: "gg")

Post.create(title: "Did I Ever Tell You I Studied In Paris?", image_url: "https://www.sortiraparis.com/images/58/1467/523198-visuel-paris-tour-eiffel.jpg", content: "The year was 2016, and as I left the stunning metropolis of Cleveland, OH - the place I call my home, I began my journey overseas with a fateful trip to Toronto, CA.", user_id: olivia.id)

Post.create(title: "Yolanda Made Me Go To Greece - You'll NEVER Guess What Happened!", image_url: "https://perezhilton.com/wp-content/uploads/2019/08/gigi-hadid-robbed-greece.jpg", content: "So my mom totally like forced me and my sister Bella to go to Greece. I'm like 'ugh, mom! Santorini is like, so 2015! But of course I still went, and I COULD NOT believe, but ...", user_id: gigi.id )