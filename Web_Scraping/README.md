*Beautiful Soup*

Leveraged Beautiful Soup and MongoDB to scrape NASA's website
![img1].(screenshot.png)


Final code:

        for result in results:
            title = result.find('div', class_='content_title').text
            p = result.find('div', class_='rollover_description_inner').text

            #Dictionary to appended into MongoDB
            post = {
                    'title': title,
                    'Article_teaser': p,
                }

        #     # Insert dictionary into MongoDB as a document
            collection.insert_one(post)

            print('---------------')
            print(title)
            print(p)


Scraped Text:

---------------


NASA Invests in Visionary Technology 



NASA is investing in technology concepts, including several from JPL, that may one day be used for future space exploration missions.

---------------


NASA is Ready to Study the Heart of Mars



NASA is about to go on a journey to study the center of Mars.

---------------


NASA Briefing on First Mission to Study Mars Interior



NASA’s next mission to Mars will be the topic of a media briefing Thursday, March 29, at JPL. The briefing will air live on NASA Television and the agency’s website.

---------------


New 'AR' Mobile App Features 3-D NASA Spacecraft



NASA spacecraft travel to far-off destinations in space, but a new mobile app produced by NASA's Jet Propulsion Laboratory, Pasadena, California, brings spacecraft to users.

---------------


Witness First Mars Launch from West Coast



NASA invites digital creators to apply for social media credentials to cover the launch of the InSight mission to Mars, May 3-5, at California's Vandenberg Air Force Base.

---------------


NASA InSight Mission to Mars Arrives at Launch Site



NASA's InSight spacecraft has arrived at Vandenberg Air Force Base in central California to begin final preparations for a launch this May.
