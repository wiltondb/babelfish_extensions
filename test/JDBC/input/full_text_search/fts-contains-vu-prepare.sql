-- enable CONTAINS
SELECT set_config('babelfishpg_tsql.escape_hatch_fulltext', 'ignore', 'false')
GO

-- Create table for full text search CONTAINS predicate
CREATE TABLE fts_contains_vu_t (id int PRIMARY KEY, txt text)
GO

-- Full text search @query_string using CONTAINS
-- Optional parameter @top_n to filter top n rows of output
CREATE PROCEDURE fts_contains_vu_prepare_p1
    @query_string text,
    @top_n int = -1
AS
BEGIN
    IF @top_n >= 0
    BEGIN
        SELECT TOP(@top_n) * FROM fts_contains_vu_t WHERE CONTAINS(txt, @query_string) ORDER BY id
    END
    ELSE
    BEGIN
        SELECT * FROM fts_contains_vu_t WHERE CONTAINS(txt, @query_string) ORDER BY id
    END
END
GO

CREATE VIEW fts_contains_rewrite_v1 AS
(
    SELECT (sys.babelfish_fts_contains_rewrite('like'))
)
GO

CREATE VIEW fts_contains_rewrite_v2 AS
(
    SELECT (sys.babelfish_fts_contains_phrase_helper('"word1 word2 word3"'))
)
GO

CREATE VIEW fts_contains_rewrite_v3 AS
(
    SELECT (sys.babelfish_fts_contains_rewrite('FORMSOF(INFLECTIONAL, play, move)'))
)
GO

CREATE VIEW fts_contains_rewrite_v4 AS
(
    SELECT (sys.babelfish_fts_contains_generation_term_helper('FORMSOF(INFLECTIONAL, word1, "word2 word3")'))
)
GO

CREATE VIEW fts_contains_pgconfig_v1 AS
(
    SELECT CAST((sys.babelfish_fts_contains_pgconfig('like')) AS text)
)
GO

-- initialize table: txt column has 1000 sentences from NOW corpus
INSERT INTO fts_contains_vu_t VALUES (1, '<p> Sol Yurick , the writer whose 1965 novel " The Warriors " was adapted into a film 14 years later -- which then became one of the best adapted works ever in video gaming -- died this weekend ')
GO

INSERT INTO fts_contains_vu_t VALUES (2, ' He was 88 ')
GO

INSERT INTO fts_contains_vu_t VALUES (3, 'Yurick ''s work itself was a loose adaptation of a story told 2,300 years before : Anabasis , which chronicles the journey of Greek mercenaries through hostile territory after the death of their leader ')
GO

INSERT INTO fts_contains_vu_t VALUES (4, ' Yurick ''s book , and The Warriors both open with a grand council of street gangs , convened in the Bronx , and the murder of the leader who called for the gathering ( Cyrus , a direct reference to the leader of the Greeks in Anabasis ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (5, ' But the stories then diverge significantly ')
GO

INSERT INTO fts_contains_vu_t VALUES (6, 'Walter Hill , the director of The Warriors , strove to give a comic-book depiction of the gang ''s flight from the Bronx back to their Coney Island turf ')
GO

INSERT INTO fts_contains_vu_t VALUES (7, ' ( Indeed , in Yurick ''s book , the gang ''s mascot , Junior , reads a comic book version of @ @ @ @ @ @ @ @ @ @ , each faction was given a name and a costume theme invoking it , typified by the iconic " Baseball Furies " the protagonist Warriors fight in Riverside Park ')
GO

INSERT INTO fts_contains_vu_t VALUES (8, ' After making their way through rival gangs '' turf in Manhattan and then back to Coney Island , the Warriors defeat the gang responsible for Cyrus '' death ')
GO

INSERT INTO fts_contains_vu_t VALUES (9, 'Advertisement')
GO

INSERT INTO fts_contains_vu_t VALUES (10, 'The Warriors became a cult hit , partly because its exaggerated portrayal of New York City ''s lawlessness fit with the image of violent crime and decay that blighted the city in the late 1970s ')
GO

INSERT INTO fts_contains_vu_t VALUES (11, ' A staple of Saturday and Sunday afternoon movie programming on UHF stations , the film faded from popular memory until Rockstar resurrected it as a video game 26 years later ')
GO

INSERT INTO fts_contains_vu_t VALUES (12, 'Sponsored')
GO

INSERT INTO fts_contains_vu_t VALUES (13, 'The Warriors , released in 2005 for the Xbox and PS2 , began with a three-minute recreation of the film ''s opening sequence ( shown above ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (14, ' Set to the blood pumping guitar and synthesizer of Barry Vorzon ''s original soundtrack , it ''s one of the best openings a video game has ever had ')
GO

INSERT INTO fts_contains_vu_t VALUES (15, ' Critics familiar @ @ @ @ @ @ @ @ @ @ well in a year full of big hits ')
GO

INSERT INTO fts_contains_vu_t VALUES (16, ' Primarily a brawler , with some limited open-world features , the game also served as a canonical prologue to the all-gang meeting in the Bronx ')
GO

INSERT INTO fts_contains_vu_t VALUES (17, ' It is playable only on the PlayStation 2 and original Xbox ; a version for the PSP was released in 2007')
GO

INSERT INTO fts_contains_vu_t VALUES (18, '<h> That ''s What They Say : Dialect Society chooses its words of the year')
GO

INSERT INTO fts_contains_vu_t VALUES (19, 'For this week ''s edition of " That ''s What They Say , " University of Michigan Professor Anne Curzan spoke with us from Boston , where she was attending the American Dialect Society ''s annual meeting , whose 200 members voted on their " Word of the Year ')
GO

INSERT INTO fts_contains_vu_t VALUES (20, 'Rina Miller : So the winner is ?')
GO

INSERT INTO fts_contains_vu_t VALUES (21, 'Anne : The winner is " hashtag ')
GO

INSERT INTO fts_contains_vu_t VALUES (22, ' " It was a surprise entry ')
GO

INSERT INTO fts_contains_vu_t VALUES (23, ' It was nominated from the floor ')
GO

INSERT INTO fts_contains_vu_t VALUES (24, ' I must admit , I went in thinking " fiscal cliff " had this hands down ')
GO

INSERT INTO fts_contains_vu_t VALUES (25, ' I thought there was no way anything would beat that , but fiscal cliff did n''t even make the runoff ')
GO

INSERT INTO fts_contains_vu_t VALUES (26, ' It was hashtag vs')
GO

INSERT INTO fts_contains_vu_t VALUES (27, ' marriage equality ')
GO

INSERT INTO fts_contains_vu_t VALUES (28, 'Rina : Why hashtag ?')
GO

INSERT INTO fts_contains_vu_t VALUES (29, 'Anne : The argument was that while the word hashtag has been around since 2007 , this was the year of the hashtag ')
GO

INSERT INTO fts_contains_vu_t VALUES (30, ' This was the year that hashtag was everywhere in the Twittersphere and beyond @ @ @ @ @ @ @ @ @ @ , making memes go viral ')
GO

INSERT INTO fts_contains_vu_t VALUES (31, 'Rina : And what were the winners in some of the other categories ?')
GO

INSERT INTO fts_contains_vu_t VALUES (32, 'Anne : Marriage equality , which was in the runoff for word of the year , actually won most likely to succeed ')
GO

INSERT INTO fts_contains_vu_t VALUES (33, ' And I thought it was a very interesting entry ')
GO

INSERT INTO fts_contains_vu_t VALUES (34, ' The argument was that as the country has changed its attitudes about marriage equality , we ''ve seen the terminology shift from same-sex marriage or gay marriage to marriage equality ')
GO

INSERT INTO fts_contains_vu_t VALUES (35, ' And people pointed out that when textbooks write this up as a movement , it will be about the movement for marriage equality ')
GO

INSERT INTO fts_contains_vu_t VALUES (36, 'Rina : Tell us about some of the other categories ')
GO

INSERT INTO fts_contains_vu_t VALUES (37, 'Anne : One of my favorites , most years , is the most creative word of the year ')
GO

INSERT INTO fts_contains_vu_t VALUES (38, ' And there were two terrific candidates this year ')
GO

INSERT INTO fts_contains_vu_t VALUES (39, ' One is " mansplaining , " which is defined as a man ''s condescending explanation to a female audience ')
GO

INSERT INTO fts_contains_vu_t VALUES (40, ' It ''s designed to capture a certain kind of male behavior ')
GO

INSERT INTO fts_contains_vu_t VALUES (41, ' It did mean that during the discussion of @ @ @ @ @ @ @ @ @ @ talking because they could easily be accused of mansplaining every time they tried to say anything , even though it was a mixed-gender audience ')
GO

INSERT INTO fts_contains_vu_t VALUES (42, 'Rina : That ''s never happened to me , has it to you , Anne ?')
GO

INSERT INTO fts_contains_vu_t VALUES (43, 'Anne : No , never ')
GO

INSERT INTO fts_contains_vu_t VALUES (44, 'The mansplaining was up against " gate lice " -- a description of passengers on an airplane who crowd around the gate waiting to board ')
GO

INSERT INTO fts_contains_vu_t VALUES (45, 'Rina : I love that !')
GO

INSERT INTO fts_contains_vu_t VALUES (46, 'Anne : I loved it , too , and I particularly liked the singular , which is gate louse ')
GO

INSERT INTO fts_contains_vu_t VALUES (47, 'Rina : And who does n''t know that ? Maybe we ''ve even been a louse ')
GO

INSERT INTO fts_contains_vu_t VALUES (48, 'Anne : And now we have such a great way to talk about it ')
GO

INSERT INTO fts_contains_vu_t VALUES (49, ' We can say , " Look at all the gate lice ')
GO

INSERT INTO fts_contains_vu_t VALUES (50, 'Rina : There ''s also the most unnecessary and the most outrageous categories ')
GO

INSERT INTO fts_contains_vu_t VALUES (51, ' Those are more serious ')
GO

INSERT INTO fts_contains_vu_t VALUES (52, 'Anne : They are more serious ')
GO

INSERT INTO fts_contains_vu_t VALUES (53, ' And this year the same phrase won in both categories ')
GO

INSERT INTO fts_contains_vu_t VALUES (54, ' It @ @ @ @ @ @ @ @ @ @ Senate candidate Todd Akins ')
GO

INSERT INTO fts_contains_vu_t VALUES (55, ' And someone pointed out when we were voting for most unnecessary , that it came up again under most outrageous on the ballot ')
GO

INSERT INTO fts_contains_vu_t VALUES (56, ' And someone yelled out , " It should win both ')
GO

INSERT INTO fts_contains_vu_t VALUES (57, ' " And it did ')
GO

INSERT INTO fts_contains_vu_t VALUES (58, 'Rina : And which word was least likely to succeed ?')
GO

INSERT INTO fts_contains_vu_t VALUES (59, 'Anne : That was a tie ')
GO

INSERT INTO fts_contains_vu_t VALUES (60, ' One of the first I remember ')
GO

INSERT INTO fts_contains_vu_t VALUES (61, ' It was a tie between " YOLO , " which our listeners over about 25 or 30 may be less familiar with ')
GO

INSERT INTO fts_contains_vu_t VALUES (62, ' It is an acronym for " you only live once ')
GO

INSERT INTO fts_contains_vu_t VALUES (63, ' " It came to prominence this year from the rapper , Drake ')
GO

INSERT INTO fts_contains_vu_t VALUES (64, ' He had a song in which he talked about you only live once -- YOLO -- and I think there are a number of young people who got YOLO tattoos , which they are going to come to regret , because students tell me it is already very unhip ')
GO

INSERT INTO fts_contains_vu_t VALUES (65, 'YOLO tied with " phablet , " which is apparently a mid-sized electronic device between a smart phone and a tablet @ @ @ @ @ @ @ @ @ @ Anne : For the most useful , we had two combining forms ')
GO

INSERT INTO fts_contains_vu_t VALUES (66, ' " Pocalypse " or " mageddon , " which you ''ll hear people attach to things like " snowmaggedon " or " oilpocalypse " to describe a huge oil spill as a hyperbolic way to talk about a catastrophe ')
GO

INSERT INTO fts_contains_vu_t VALUES (67, 'Rina : There had to be something that came out of the elections ')
GO

INSERT INTO fts_contains_vu_t VALUES (68, 'Anne : The election phrase of the year is " binders full of women ')
GO

INSERT INTO fts_contains_vu_t VALUES (69, ' " After presidential candidate Mitt Romney said that , it instantly became a hashtag , and many people have probably seen it circulating online ')
GO

INSERT INTO fts_contains_vu_t VALUES (70, ' It beat " 47 percent , " which was also up for word of the year ')
GO

INSERT INTO fts_contains_vu_t VALUES (71, ' So both 47 percent and " fiscal cliff " did n''t win anything ')
GO

INSERT INTO fts_contains_vu_t VALUES (72, '<h> A sublime croissant at French Tart in Grant City , Staten Island ')
GO

INSERT INTO fts_contains_vu_t VALUES (73, 'French Tart chef Laurent Chavenet claims to work in the only authentic French cafe and restaurant in Staten Island ')
GO

INSERT INTO fts_contains_vu_t VALUES (74, ' And he just might be right ')
GO

INSERT INTO fts_contains_vu_t VALUES (75, ' Opened in 2009 , French Tart is one of those hidden gems that food lovers so often hear about in the outer boroughs , but so rarely find ')
GO

INSERT INTO fts_contains_vu_t VALUES (76, ' Baked fresh every morning by Chavenet himself , the croissants are a work of art ')
GO

INSERT INTO fts_contains_vu_t VALUES (77, ' The texture runs from crispy on the outside to soft and airy on the inside ')
GO

INSERT INTO fts_contains_vu_t VALUES (78, ' According to Chavenet , the secret to making a great croissant is in quality ingredients , especially the butter , and the folding of the dough , which Chavenet demonstrates on a napkin ')
GO

INSERT INTO fts_contains_vu_t VALUES (79, ' While the plain croissant is outstanding , the almond croissant is truly world-class ')
GO

INSERT INTO fts_contains_vu_t VALUES (80, ' Moist , sweet and decadent , it ''s more of a dessert than a breakfast item , but go ahead and dig in any time of day ')
GO

INSERT INTO fts_contains_vu_t VALUES (81, ' After all , life is short ')
GO

INSERT INTO fts_contains_vu_t VALUES (82, ' Eat dessert @ @ @ @ @ @ @ @ @ @ Colson Patisserie , in Park Slope , uses two types of flour in its croissants ')
GO

INSERT INTO fts_contains_vu_t VALUES (83, 'In 1986 , pastry chef Hubert Colson first opened his famed pastry shop in Mons , Belgium ')
GO

INSERT INTO fts_contains_vu_t VALUES (84, ' Barely 20 years later , Yonatan Israel , a French filmmaker searching for structure and opportunity in life , opened his own shop as a tribute to his favorite pastry chef ')
GO

INSERT INTO fts_contains_vu_t VALUES (85, ' And so the Park Slope outpost of Colson Patisserie was born ')
GO

INSERT INTO fts_contains_vu_t VALUES (86, ' What a gift for pastry lovers in Brooklyn ! Colson ''s croissants ( $2')
GO

INSERT INTO fts_contains_vu_t VALUES (87, '45 ) seem light enough to float above the table and rich enough to melt in your mouth ')
GO

INSERT INTO fts_contains_vu_t VALUES (88, ' Two types of flour are used in the dough , which is then folded six to eight times ')
GO

INSERT INTO fts_contains_vu_t VALUES (89, ' Eighty croissants are made daily for the pastry shop , which is small but well-lit by a storefront of large windows ')
GO

INSERT INTO fts_contains_vu_t VALUES (90, ' Sweet but not candied , these croissants taste like a big puff of flaky butter , which is just what every New Yorker needs to start off their day ')
GO

INSERT INTO fts_contains_vu_t VALUES (91, ' As Israel says , " New York is the @ @ @ @ @ @ @ @ @ @ to change that ')
GO

INSERT INTO fts_contains_vu_t VALUES (92, 'You ca n''t talk about croissants in New York City without mentioning master pastry chef Laurent Dupal and his Spring St')
GO

INSERT INTO fts_contains_vu_t VALUES (93, ' shop Ceci-Cela ')
GO

INSERT INTO fts_contains_vu_t VALUES (94, ' Since his quaint cafe opened in 1992 , Dupal has consistently made some of the flakiest , butteriest , airiest croissants ( $2 ) in the five boroughs ')
GO

INSERT INTO fts_contains_vu_t VALUES (95, ' Dupal credits fresh ingredients , a controlled setting and years of experience for the excellent taste of his croissants , hundreds of which are sold a day in the patisserie ')
GO

INSERT INTO fts_contains_vu_t VALUES (96, ' In fact , Dupal compares baking croissants with raising a child ')
GO

INSERT INTO fts_contains_vu_t VALUES (97, ' " Everyone does it differently , " he says , " and , no matter what , you have to adjust to the temperament of the dough , which ca n''t be too thin or too thick ')
GO

INSERT INTO fts_contains_vu_t VALUES (98, ' " Take some home for the whole family ')
GO

INSERT INTO fts_contains_vu_t VALUES (99, ' A pack of six frozen croissants costs $7 and can be baked at home ')
GO

INSERT INTO fts_contains_vu_t VALUES (100, 'YOUR TWO CENTS')
GO

INSERT INTO fts_contains_vu_t VALUES (101, 'The croissant at Chock Full o '' Nuts Cafe ( 1611 Avenue M , Brooklyn ) is very buttery inside and outside @ @ @ @ @ @ @ @ @ @ good with a side of butter/jelly along with a cup of regular or flavored coffee or chai latte or tea ')
GO

INSERT INTO fts_contains_vu_t VALUES (102, ' Service is very courteous , but a little slow ')
GO

INSERT INTO fts_contains_vu_t VALUES (103, ' -- Tzivia M')
GO

INSERT INTO fts_contains_vu_t VALUES (104, 'Stork ''s Bakery , located at 12-42 150th St')
GO

INSERT INTO fts_contains_vu_t VALUES (105, ' in Whitestone , makes the perfect croissant ')
GO

INSERT INTO fts_contains_vu_t VALUES (106, ' Its golden , flaky , light crust is pleasing to the eye , and it draws you into its succulent flavor , which is light , rich and satisfying ')
GO

INSERT INTO fts_contains_vu_t VALUES (107, ' Be sure to get there early in the a')
GO

INSERT INTO fts_contains_vu_t VALUES (108, ' if you wish to partake in this culinary delight ')
GO

INSERT INTO fts_contains_vu_t VALUES (109, ' They sell out quickly ')
GO

INSERT INTO fts_contains_vu_t VALUES (110, ' -- Carol D')
GO

INSERT INTO fts_contains_vu_t VALUES (111, 'The best croissant in the city can be found at City Bakery ( 3 W')
GO

INSERT INTO fts_contains_vu_t VALUES (112, ' 18th St')
GO

INSERT INTO fts_contains_vu_t VALUES (113, ' in Manhattan ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (114, ' The pretzel croissant , as it ''s called , combines the rich buttery body of a typical croissant with the salty crispness of a pretzel')
GO

INSERT INTO fts_contains_vu_t VALUES (115, ' -- Christopher O')
GO

INSERT INTO fts_contains_vu_t VALUES (116, 'The croissants at The Standard hotel are the tastiest in the city ')
GO

INSERT INTO fts_contains_vu_t VALUES (117, ' The secret is in the sourdough they add to it ! Also , buttery and flaky as all @ @ @ @ @ @ @ @ @ @ the upper West Side has the best croissant I ''ve had in NYC ')
GO

INSERT INTO fts_contains_vu_t VALUES (118, ' It ''s flaky on the outside , but buttery and perfectly doughy on the inside ')
GO

INSERT INTO fts_contains_vu_t VALUES (119, ' It ''s the best croissant I ''ve had outside of Paris ')
GO

INSERT INTO fts_contains_vu_t VALUES (120, ' -- Colman C')
GO

INSERT INTO fts_contains_vu_t VALUES (121, 'YOU SUGGEST IT , WE ''LL TEST IT')
GO

INSERT INTO fts_contains_vu_t VALUES (122, 'We ''re in search of the best of the city , but we need your help ')
GO

INSERT INTO fts_contains_vu_t VALUES (123, ' Send your picks for the following , and we ''ll try them ! \n')
GO

INSERT INTO fts_contains_vu_t VALUES (124, '<h> Reflecting on a quarter-century of growth in Portland ''s performing arts scene')
GO

INSERT INTO fts_contains_vu_t VALUES (125, 'The highlight of the Portland Center for Performing Arts '' grand-opening in 1987 was a performance by high-wire artists Phillippe Petit and Ann Seward , which reflected the thrilling risk the city had taken with the project ')
GO

INSERT INTO fts_contains_vu_t VALUES (126, ' Steven Nehl/The Oregonian')
GO

INSERT INTO fts_contains_vu_t VALUES (127, 'Stephanie Mulligan , who has been with Artists Repertory Theatre since the mid 1980s , knew the Portland theater scene in its younger , wilder days ')
GO

INSERT INTO fts_contains_vu_t VALUES (128, ' " There were more trails of glitter than there are today -- I mean that literally , " she says ')
GO

INSERT INTO fts_contains_vu_t VALUES (129, ' " I like to think there was a lot more nudity , but that might just be a trick of memory ')
GO

INSERT INTO fts_contains_vu_t VALUES (130, 'These days , Portland theater , and the city ''s arts scene in general , is n''t so stripped down ')
GO

INSERT INTO fts_contains_vu_t VALUES (131, ' But it is much more glittery , if not literally than metaphorically ')
GO

INSERT INTO fts_contains_vu_t VALUES (132, ' Look around and you ''ll see it : the sparkle of widespread creative activity , the shine of technical and artistic quality ')
GO

INSERT INTO fts_contains_vu_t VALUES (133, 'There ''s @ @ @ @ @ @ @ @ @ @ music -- most definitely in food , if you want to extend the definition of the creative culture -- and perhaps in other areas as well , this is Portland ''s golden age ')
GO

INSERT INTO fts_contains_vu_t VALUES (134, ' Sure , the city ''s artsy eccentricities can grow ripe for lampooning , as the TV spoof " Portlandia " has proved ')
GO

INSERT INTO fts_contains_vu_t VALUES (135, ' But such attention would be nonsensical ( or at least much more embarrassing ) if there was n''t more going on here than adult kickball leagues and mustache-growing contests , if many of the eccentrics were n''t really artists ')
GO

INSERT INTO fts_contains_vu_t VALUES (136, 'A certain shoestring flamboyance , as Mulligan ''s recollections of leaner times suggest , is nothing new here ')
GO

INSERT INTO fts_contains_vu_t VALUES (137, ' But the size , scope and solidity of the arts in Portland is something that ''s grown over the past quarter century ')
GO

INSERT INTO fts_contains_vu_t VALUES (138, 'That 1987 and '' 88 marked a pivotal time in Portland arts was clear even then ')
GO

INSERT INTO fts_contains_vu_t VALUES (139, ' More than a decade of planning and haggling was coming to fruition ')
GO

INSERT INTO fts_contains_vu_t VALUES (140, ' The idea for a set of new performance spaces began taking place around 1976 due to dissatisfaction with Civic Auditorium @ @ @ @ @ @ @ @ @ @ satisfying venue ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (141, ' In 1981 , voters passed a $19 million bond issue ')
GO

INSERT INTO fts_contains_vu_t VALUES (142, ' Next came political squabbles , cost overruns ( from $25 million to $41 million by the time it opened ) and a scramble to find money for operating costs ')
GO

INSERT INTO fts_contains_vu_t VALUES (143, ' But eventually the Civic was joined by the Arlene Schnitzer Concert Hall ( a refurbished 1928 movie palace ) and a new multi-use building next door ')
GO

INSERT INTO fts_contains_vu_t VALUES (144, '" Ten or 20 years from now , few will remember all the effort , dreaming , planning and yes , the bickering , mistakes and accusations that marked the creation of the Portland Center for the Performing Arts , " The Oregonian ''s Joan Laatz wrote in August , 1987 , when the multi-use New Theater Building ( now named Antoinette Hatfield Hall ) opened ')
GO

INSERT INTO fts_contains_vu_t VALUES (145, 'Meanwhile , city officials had been looking for an anchor tenant to take up residence in the center ''s the 900-seat space now known as the Newmark Theatre ')
GO

INSERT INTO fts_contains_vu_t VALUES (146, ' A study commissioned by the Fred Meyer Trust concluded that not even the city ''s top existing theater company , Portland @ @ @ @ @ @ @ @ @ @ organizationally ')
GO

INSERT INTO fts_contains_vu_t VALUES (147, ' Cynthia Fuhrman , a veteran theater marketing exec , recalls that Portland was the largest city in the country that did n''t have a company in the League of Resident Theatres , the association of major regional theaters ')
GO

INSERT INTO fts_contains_vu_t VALUES (148, ' After being courted on and off for years , Ashland ''s Oregon Shakespeare Festival signed on , and its new satellite operation , dubbed Portland Center Stage , stepped into the lights in Nov')
GO

INSERT INTO fts_contains_vu_t VALUES (149, ' 1988 ')
GO

INSERT INTO fts_contains_vu_t VALUES (150, 'After seeing the new company in the new building , Time magazine said that Portland at last could stake a claim to sophistication and social significance ')
GO

INSERT INTO fts_contains_vu_t VALUES (151, 'More so than social stature , the goal was for the PCPA to both bring more touring talents to town and give local troupes a comfortable home that would help them grow their audiences , and for PCS to provide a model of quality , stability and professionalism that might lift the community as a whole ')
GO

INSERT INTO fts_contains_vu_t VALUES (152, ' The fear was that higher production costs in the new facilities would make things tougher for most local arts companies , and that the venerable OSF @ @ @ @ @ @ @ @ @ @ ')
GO

INSERT INTO fts_contains_vu_t VALUES (153, '" There was so much buzz about OSF coming up , " recalls Beth Harper , who ''d soon launch what ''s now called Portland Actors Conservatory ')
GO

INSERT INTO fts_contains_vu_t VALUES (154, ' " I was in a show at New Rose and everyone felt like , '' The big guys are coming and we ''ve never got that kind of attention ')
GO

INSERT INTO fts_contains_vu_t VALUES (155, ' '' " " One of the things that still rings true , " Harper adds , " is the big boys are still the big boys and the small ones are still the small ones ')
GO

INSERT INTO fts_contains_vu_t VALUES (156, 'Though perhaps not ')
GO

INSERT INTO fts_contains_vu_t VALUES (157, ' Yes , Center Stage , which split from OSF to become an independent company in 1994 , remains atop the theatrical food chain ')
GO

INSERT INTO fts_contains_vu_t VALUES (158, ' What were the largest or most active homegrown companies back in the late '' 80s -- Portland Rep , New Rose , Storefront Portland Civic Theater -- long ago folded ')
GO

INSERT INTO fts_contains_vu_t VALUES (159, ' ( As Mulligan recalls , " It took about five years for the dust to settle -- unfortunately the dust was some fine companies ')
GO

INSERT INTO fts_contains_vu_t VALUES (160, ' " ) And as it did then , the @ @ @ @ @ @ @ @ @ @ stage a few shows a year in rented or makeshift spaces ')
GO

INSERT INTO fts_contains_vu_t VALUES (161, 'Numerous factors are involved , not just the anchoring effects of PCPA and PCS , but the theater scene now has a broader range of companies ')
GO

INSERT INTO fts_contains_vu_t VALUES (162, ' Artists Repertory Theatre , once a scrappy little operation in rented space at the downtown YWCA , grew to become the city ''s No')
GO

INSERT INTO fts_contains_vu_t VALUES (163, ' 2 company , with a $2')
GO

INSERT INTO fts_contains_vu_t VALUES (164, '4 million budget and its own twin-auditorium home ')
GO

INSERT INTO fts_contains_vu_t VALUES (165, ' Down the scale in budget , but punching above their weight artistically , Third Rail Rep , Portland Playhouse and Profile Theatre form a strong middle tier ')
GO

INSERT INTO fts_contains_vu_t VALUES (166, 'However persistent the funding challenges of the dance world , a similar vertical growth , if you will , can be found ')
GO

INSERT INTO fts_contains_vu_t VALUES (167, ' In the late '' 80s , Portland had both Ballet Oregon and Pacific Ballet Theatre ; for contemporary dance , Portland State University housed a concert series for touring groups and a top-notch resident company ')
GO

INSERT INTO fts_contains_vu_t VALUES (168, ' Now , Oregon Ballet Theatre ( the result of a merger of the aforementioned ballet troupes ) survives , White Bird does concert presenting at @ @ @ @ @ @ @ @ @ @ Polaris Dance Theatre each have performance spaces and expanding reputations ')
GO

INSERT INTO fts_contains_vu_t VALUES (169, '" I think the arts scene was like a young teenager then and has grown up a lot , " says Regional Arts &amp; Culture Council executive director Eloise Damrosch , who moved to Portland in '' 87 ')
GO

INSERT INTO fts_contains_vu_t VALUES (170, ' " Our reputation as a place to visit has really skyrocketed ')
GO

INSERT INTO fts_contains_vu_t VALUES (171, ' I ''m struck when I open up the A&amp;E and see all the options ')
GO

INSERT INTO fts_contains_vu_t VALUES (172, ' There ''s a lot more happening , and such a range ')
GO

INSERT INTO fts_contains_vu_t VALUES (173, 'Quantity is n''t the only thing that ''s changed ')
GO

INSERT INTO fts_contains_vu_t VALUES (174, '" Back then , there was this grittier , shoestring quality that imbued almost every company , " Mulligan says ')
GO

INSERT INTO fts_contains_vu_t VALUES (175, ' " The dedication to art was inspiring ')
GO

INSERT INTO fts_contains_vu_t VALUES (176, ' But when I look back at that earlier renaissance of the '' 80s , the truth was the talent pool of the city needed to step up ')
GO

INSERT INTO fts_contains_vu_t VALUES (177, 'Jim Fullan , who has worked in marketing at Portland Opera and the Oregon Symphony , says the city has developed a " radically different sense of our place @ @ @ @ @ @ @ @ @ @ such an inferiority complex regarding Seattle , San Francisco and Los Angeles that it distrusted artistic ambition ')
GO

INSERT INTO fts_contains_vu_t VALUES (178, ' " The public would punish you for getting too big for your britches ')
GO

INSERT INTO fts_contains_vu_t VALUES (179, ' The prevailing attitude was , '' It ''s good enough for us ')
GO

INSERT INTO fts_contains_vu_t VALUES (180, ' We like it ')
GO

INSERT INTO fts_contains_vu_t VALUES (181, ' '' Now , that ''s totally gone ')
GO

INSERT INTO fts_contains_vu_t VALUES (182, ' It ''s almost the opposite ')
GO

INSERT INTO fts_contains_vu_t VALUES (183, ' If you ''re not aspiring to be world-class , you ''re not on the boat ')
GO

INSERT INTO fts_contains_vu_t VALUES (184, ' The arts -- in tandem with food , beer and wine -- have raised us up ')
GO

INSERT INTO fts_contains_vu_t VALUES (185, 'The building of the PCPA has n''t solved all of the performance-space issues for local companies ( there ''s a big , problematic gap between the 900-seat Newmark and the Schnitzer and Keller , which seat close to 3,000 ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (186, ' And it ''s notable that Center Stage had to move to a home of its own , a renovated 19th-century armory in the Pearl District , to begin fulfilling its potential as a truly vibrant hub for the theater scene ')
GO

INSERT INTO fts_contains_vu_t VALUES (187, ' But those two big moves have , over time , proved @ @ @ @ @ @ @ @ @ @ other developments have helped shape the Portland of today ')
GO

INSERT INTO fts_contains_vu_t VALUES (188, ' Some observers point to the fundraising success of John and Lucy Buchanan at the Portland Art Museum 1994 to 2005 ')
GO

INSERT INTO fts_contains_vu_t VALUES (189, ' " They actually made a case that a great city needs great art , " says BodyVox co-founder Jamey Hampton ')
GO

INSERT INTO fts_contains_vu_t VALUES (190, ' " And that put a gauntlet down ')
GO

INSERT INTO fts_contains_vu_t VALUES (191, 'Leadership changes in 2003 at Portland Opera , Oregon Ballet Theatre and the Oregon Symphony also marked a crucial transition ')
GO

INSERT INTO fts_contains_vu_t VALUES (192, ' Hampton points to Tom Manley , president of Pacific Northwest College of Art as " probably the best leader of an arts organization the city has ')
GO

INSERT INTO fts_contains_vu_t VALUES (193, ' " PNCA has grown to be a leading creative and economic force in the Pearl District ')
GO

INSERT INTO fts_contains_vu_t VALUES (194, ' and it ''s in the process of remaking how that neighborhood looks ')
GO

INSERT INTO fts_contains_vu_t VALUES (195, ' It ''s not splashy , like when Pink Martini plays New Year ''s Eve at the Schnitz ')
GO

INSERT INTO fts_contains_vu_t VALUES (196, ' It ''s quiet , but it ''s really foundational ')
GO

INSERT INTO fts_contains_vu_t VALUES (197, 'Through it all , the essential challenges remain much the same : make good work , expand audiences , cultivate donors @ @ @ @ @ @ @ @ @ @ business model , away from a focus on big-money patrons and toward building long-term relationships with supporters of all sorts , nurturing them along the path from first-time ticket buyer to subscriber to contributor and so on ')
GO

INSERT INTO fts_contains_vu_t VALUES (198, ' Others point out that the city is awash in heavily subsidized art -- but that the artists themselves provide the subsidy comes from the artists themselves , in the form of the second jobs , lack of health care , or multiple roommates that allow them to subsist as artists ')
GO

INSERT INTO fts_contains_vu_t VALUES (199, 'All together , what ''s changed and what ''s stayed the same add up to an arts scene that , while still facing major challenges , has grown bigger , wider and better integrated into the world around it ')
GO

INSERT INTO fts_contains_vu_t VALUES (200, '" I do n''t think it happens in isolation , " Fuhrman says ')
GO

INSERT INTO fts_contains_vu_t VALUES (201, ' " It ''s about the growth of the city as a whole ')
GO

INSERT INTO fts_contains_vu_t VALUES (202, '<h> Ask Ars : Does Facebook auto-delete content after a certain period of time ?')
GO

INSERT INTO fts_contains_vu_t VALUES (203, 'Ars reader wants to create a page for an ancestor , but worries about losing content ')
GO

INSERT INTO fts_contains_vu_t VALUES (204, 'In 1998 , Ask Ars was an early feature of the newly launched Ars Technica ')
GO

INSERT INTO fts_contains_vu_t VALUES (205, ' Now , as then , it ''s all about your questions and our community ''s answers ')
GO

INSERT INTO fts_contains_vu_t VALUES (206, ' We occasionally dig into our question bag , provide our own take , then tap the wisdom of our readers ')
GO

INSERT INTO fts_contains_vu_t VALUES (207, ' To submit your own question , see our helpful tips page ')
GO

INSERT INTO fts_contains_vu_t VALUES (208, 'I ask , because I want to use Facebook to create a historical timeline about an ancestor in my family so people can learn more about their heritage ')
GO

INSERT INTO fts_contains_vu_t VALUES (209, ' I have Googled my question several times and all answers are confusing and mixed : some say everything stays on a FB page until you clean it off and others say Facebook deletes status updates and photos monthly ')
GO

INSERT INTO fts_contains_vu_t VALUES (210, 'This is an interesting way to use Facebook -- to create a page for someone who is not @ @ @ @ @ @ @ @ @ @ existed ')
GO

INSERT INTO fts_contains_vu_t VALUES (211, ' ( Typically , the question is the other way around : what to do with someone ''s existing Facebook account after they pass away ? ) And given the level of confusion constantly floating around about Facebook ''s data retention policies , it ''s no surprise that it might be hard to pinpoint exactly when ( if ever ) information gets deleted from the social network ')
GO

INSERT INTO fts_contains_vu_t VALUES (212, 'We store data for as long as it is necessary to provide products and services to you and others , including those described above ')
GO

INSERT INTO fts_contains_vu_t VALUES (213, ' Typically , information associated with your account will be kept until your account is deleted ')
GO

INSERT INTO fts_contains_vu_t VALUES (214, ' For certain categories of data , we may also tell you about specific data retention practices ')
GO

INSERT INTO fts_contains_vu_t VALUES (215, 'Just to be sure , we reached out to Facebook to confirm this is indeed the policy for the above use case ')
GO

INSERT INTO fts_contains_vu_t VALUES (216, ' The company confirmed that as long as you have not deleted the content yourself -- or in the case of a message between two people , both people have not deleted it -- the content should stay online indefinitely @ @ @ @ @ @ @ @ @ @ to keep in mind about this policy ')
GO

INSERT INTO fts_contains_vu_t VALUES (217, ' If you ever do want to delete the content , you should know that it ''s not likely to disappear instantly ')
GO

INSERT INTO fts_contains_vu_t VALUES (218, ' As you may remember , we followed a thread for several years over how fast photos are deleted from Facebook ''s servers once you delete them from the site ; as of late 2012 , we verified that photos indeed appear to be removed within 30 days of deletion ( our tests showed they were actually removed much faster ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (219, 'It ''s not just about photos , though ')
GO

INSERT INTO fts_contains_vu_t VALUES (220, ' As outlined in the same Data Use Policy referenced above , there are major differences between deactivating an account versus deleting an account , should you choose to eventually remove the account you created for your ancestor ')
GO

INSERT INTO fts_contains_vu_t VALUES (221, ' Many Facebook users mistakenly think that deactivating their accounts equals deletion , but that is not so :')
GO

INSERT INTO fts_contains_vu_t VALUES (222, 'Deactivating your account puts your account on hold ')
GO

INSERT INTO fts_contains_vu_t VALUES (223, ' Other users will no longer see your timeline , but we do not delete any of your information ')
GO

INSERT INTO fts_contains_vu_t VALUES (224, ' Deactivating an account is the @ @ @ @ @ @ @ @ @ @ because you might want to reactivate your account at some point in the future ')
GO

INSERT INTO fts_contains_vu_t VALUES (225, ' You can deactivate your account on your account settings page ')
GO

INSERT INTO fts_contains_vu_t VALUES (226, 'Your friends will still see you listed in their list of friends while your account is deactivated ')
GO

INSERT INTO fts_contains_vu_t VALUES (227, 'So when you deactivate your ancestor ''s account , it ''s not really going anywhere ')
GO

INSERT INTO fts_contains_vu_t VALUES (228, ' The data is still there , lurking somewhere on Facebook ''s servers , even if the " friends " of that account can no longer see it ')
GO

INSERT INTO fts_contains_vu_t VALUES (229, 'Deletion , however , is another matter :')
GO

INSERT INTO fts_contains_vu_t VALUES (230, 'When you delete an account , it is permanently deleted from Facebook ')
GO

INSERT INTO fts_contains_vu_t VALUES (231, ' It typically takes about one month to delete an account , but some information may remain in backup copies and logs for up to 90 days ')
GO

INSERT INTO fts_contains_vu_t VALUES (232, ' You should only delete your account if you are sure you never want to reactivate it ')
GO

INSERT INTO fts_contains_vu_t VALUES (233, 'Certain information is needed to provide you with services , so we only delete this information after you delete your account ')
GO

INSERT INTO fts_contains_vu_t VALUES (234, ' Some of the things you do on Facebook are @ @ @ @ @ @ @ @ @ @ group or sending someone a message ( where your friend may still have a message you sent , even after you delete your account ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (235, ' That information remains after you delete your account ')
GO

INSERT INTO fts_contains_vu_t VALUES (236, 'I often see Facebook users confusing these two things ')
GO

INSERT INTO fts_contains_vu_t VALUES (237, ' They usually become alarmed when they ''ve deactivated an account , only to have all the old information show up again when they go to " register " a new account ')
GO

INSERT INTO fts_contains_vu_t VALUES (238, ' But if you actually go through with a real deletion , the information should n''t be there past 90 days -- and hopefully it will be gone sooner ')
GO

INSERT INTO fts_contains_vu_t VALUES (239, '<p> NEW YORK -- An associate of a notorious Russian arms dealer was arrested in Australia and charged with conspiring to buy planes so that weapons could be transported to the world ''s bloodiest conflicts , a U')
GO

INSERT INTO fts_contains_vu_t VALUES (240, ' prosecutor announced Thursday ')
GO

INSERT INTO fts_contains_vu_t VALUES (241, 'Syrian-born American Richard Ammar Chichakli was arrested Wednesday at the request of U')
GO

INSERT INTO fts_contains_vu_t VALUES (242, ' authorities on charges that he conspired with Russian arms merchant Viktor Bout and others to try to buy the planes from two U')
GO

INSERT INTO fts_contains_vu_t VALUES (243, ' companies ')
GO

INSERT INTO fts_contains_vu_t VALUES (244, 'Sukree Sukplang / Reuters file')
GO

INSERT INTO fts_contains_vu_t VALUES (245, 'Suspected Russian arms dealer Viktor Bout speaks to the media after arriving at a Bangkok criminal court August 20 , 2010 , ahead of an expected appeal court verdict on whether to extradite him to the U')
GO

INSERT INTO fts_contains_vu_t VALUES (246, 'His arrest was first confirmed by the Australian Fairfax Media news organization , which reported Thursday that he was arrested in Melbourne after applying for a post in the government Protective Service Office , a law enforcement agency ')
GO

INSERT INTO fts_contains_vu_t VALUES (247, ' The news service reported that he said nothing during a Thursday hearing at the Melbourne Magistrates Court ')
GO

INSERT INTO fts_contains_vu_t VALUES (248, 'A lawyer for Chichakli @ @ @ @ @ @ @ @ @ @ Almustafa ')
GO

INSERT INTO fts_contains_vu_t VALUES (249, ' Chichakli was held pending the processing of a U')
GO

INSERT INTO fts_contains_vu_t VALUES (250, ' extradition request ')
GO

INSERT INTO fts_contains_vu_t VALUES (251, 'Victoria state police spokeswoman Jessica Rosewarne confirmed Chichakli was caught after applying for the government post ')
GO

INSERT INTO fts_contains_vu_t VALUES (252, '" He was identified as a person of interest through routine background checks as part of the application process , " she said ')
GO

INSERT INTO fts_contains_vu_t VALUES (253, ' " He had not been offered employment with Victoria police or started any training ')
GO

INSERT INTO fts_contains_vu_t VALUES (254, ' Attorney Preet Bharara , the chief federal prosecutor in New York , said Chichakli " consorted with the world ''s most notorious arms trafficker in the purchase of aircraft that would be used to transport weapons to some of the world ''s bloodiest conflict zones , in violation of international sanctions ')
GO

INSERT INTO fts_contains_vu_t VALUES (255, 'Michele M')
GO

INSERT INTO fts_contains_vu_t VALUES (256, ' Leonhart , administrator of the Drug Enforcement Administration , said the international law enforcement community has long recognized Chichakli as a key criminal facilitator in Bout ''s global weapons trafficking regime ')
GO

INSERT INTO fts_contains_vu_t VALUES (257, '" His arrest means the world is safer and more secure , " she said in a release ')
GO

INSERT INTO fts_contains_vu_t VALUES (258, 'Merchant of Death Bout is a former @ @ @ @ @ @ @ @ @ @ his 1990s-era notoriety for running a fleet of aging Soviet-era cargo planes to conflict-ridden hotspots in Africa ')
GO

INSERT INTO fts_contains_vu_t VALUES (259, ' He also inspired the arms dealer character played by Nicolas Cage in the 2005 film " Lord of War ')
GO

INSERT INTO fts_contains_vu_t VALUES (260, 'An indictment against Chichakli in U')
GO

INSERT INTO fts_contains_vu_t VALUES (261, ' District Court in Manhattan and other court documents accuse Chichakli of working as a close associate of Bout since at least the mid-1990s to assemble a fleet of cargo planes capable of shipping weapons and military equipment to various parts of the world , including Africa , South America and the Middle East ')
GO

INSERT INTO fts_contains_vu_t VALUES (262, 'Prosecutors say the arms have helped fuel conflicts and support regimes in Afghanistan , Angola , The Democratic Republic of the Congo , Liberia , Rwanda , Sierra Leone and Sudan ')
GO

INSERT INTO fts_contains_vu_t VALUES (263, 'Over the years , Chichakli has weaved a colorful biography of his past but often repudiated his comments under the glare of law enforcement scrutiny ')
GO

INSERT INTO fts_contains_vu_t VALUES (264, 'He has claimed to have befriended a young Osama bin Laden during college days at Riyadh University in Saudi Arabia ')
GO

INSERT INTO fts_contains_vu_t VALUES (265, ' He also claimed a stint in the U')
GO

INSERT INTO fts_contains_vu_t VALUES (266, ' Army @ @ @ @ @ @ @ @ @ @ Gulf War ')
GO

INSERT INTO fts_contains_vu_t VALUES (267, 'The indictment accuses Chichakli and Bout of violating sanctions by arranging to buy two Boeing aircraft from U')
GO

INSERT INTO fts_contains_vu_t VALUES (268, ' companies in 2007 ')
GO

INSERT INTO fts_contains_vu_t VALUES (269, ' It says they electronically transferred more than $1')
GO

INSERT INTO fts_contains_vu_t VALUES (270, '7 million through banks in New York and into bank accounts in the U')
GO

INSERT INTO fts_contains_vu_t VALUES (271, ' , though the money was blocked by the U')
GO

INSERT INTO fts_contains_vu_t VALUES (272, ' Department of the Treasury before it reached the aviation companies '' accounts ')
GO

INSERT INTO fts_contains_vu_t VALUES (273, 'The Treasury Department had imposed an asset freeze against Chichakli in April 2005 as part of larger financial sanctions aimed at the Bout network ''s dealings with the dictatorial regime of Liberian President Charles Taylor ')
GO

INSERT INTO fts_contains_vu_t VALUES (274, ' The department called Chichakli , who once ran a small conglomerate of Texas-based businesses from a Dallas suburb , " Bout ''s U')
GO

INSERT INTO fts_contains_vu_t VALUES (275, '-based chief financial officer ')
GO

INSERT INTO fts_contains_vu_t VALUES (276, 'If convicted , Chichakli could face up to 20 years in prison on each of nine counts , including conspiracy to violate the International Emergency Economic Powers Act , money laundering conspiracy , wire fraud conspiracy and wire fraud ')
GO

INSERT INTO fts_contains_vu_t VALUES (277, '<p> IRELAND ''S Olympic bronze medallist Michael Conlan and reigning European champion Andrew Selby from Wales resume one of amateur boxing ''s most compelling rivalries when the World Series of Boxing heads to Bethnal Green ''s historic York Hall tomorrow')
GO

INSERT INTO fts_contains_vu_t VALUES (278, 'Conlan will be representing the USA Knockouts franchise in the team competition while Selby intends to do his bit to extend the GB Lionhearts '' unbeaten home record , but the real allure of the contest lies in the simple notion of repeat or revenge ')
GO

INSERT INTO fts_contains_vu_t VALUES (279, 'Selby beat Conlan by a single point in a hotly contested flyweight quarter-final in the World Championships in Baku in 2011 , the Welshman going on to reach the final where he lost an equally slim verdict to Misha Aloian of Russia ')
GO

INSERT INTO fts_contains_vu_t VALUES (280, '" I would n''t say there is bad blood between us but there is certainly some tension because he won our last fight by a point and I thought I had done enough to win , " the 21-year-old Conlan told the Press Association ')
GO

INSERT INTO fts_contains_vu_t VALUES (281, 'The pair narrowly missed the chance of a return match @ @ @ @ @ @ @ @ @ @ beaten in the quarter-final by Cuba ''s brilliant Robeisy Ramirez Carrazana ')
GO

INSERT INTO fts_contains_vu_t VALUES (282, 'Carrazana went on to clearly beat Conlan in the last four , consigning the Irishman to a bronze medal which saw him return home to a hero ''s welcome and his own mural on the corner of his home street in west Belfast ')
GO

INSERT INTO fts_contains_vu_t VALUES (283, 'Thursday ''s bout will be the first time Conlan has fought since his defeat to the Cuban ')
GO

INSERT INTO fts_contains_vu_t VALUES (284, '" It has been a very enjoyable time since the Olympics but I would n''t say it has affected my training very much , " Conlan said ')
GO

INSERT INTO fts_contains_vu_t VALUES (285, '" I have been in the gym for the last 12 weeks and the only difference is I get recognised more , which the mural at the bottom of my street probably helps ')
GO

INSERT INTO fts_contains_vu_t VALUES (286, ' It was very unexpected and a great honour for me ')
GO

INSERT INTO fts_contains_vu_t VALUES (287, 'While Selby was bitterly disappointed to return home from the Olympics without a medal , he remains one of the best 52kg fighters in the business , having long since shrugged off the chronic weight problems that once @ @ @ @ @ @ @ @ @ @ a pasty this week for the first time in ages , " Selby said ')
GO

INSERT INTO fts_contains_vu_t VALUES (288, '" There was a time when I could n''t eat for two days before a bout and had to spend the whole time running and skipping to get the weight off ')
GO

INSERT INTO fts_contains_vu_t VALUES (289, '" It definitely affected my performances but I ''ve got over it now and I feel so much stronger and sharper ')
GO

INSERT INTO fts_contains_vu_t VALUES (290, ' I ca n''t wait to get back in the ring with Michael ')
GO

INSERT INTO fts_contains_vu_t VALUES (291, '" It ''s going to be a very tough fight ')
GO

INSERT INTO fts_contains_vu_t VALUES (292, ' I know he ''s going to be wanting revenge ')
GO

INSERT INTO fts_contains_vu_t VALUES (293, 'Despite its rather contrived franchise system which will see two of Conlan ''s Ireland team-mates - John Joe Nevin and Joe Ward - lining up for the opposite side , the WSB is clearly made for the likes of Conlan and Selby , intent on keeping the lure of pros at bay ')
GO

INSERT INTO fts_contains_vu_t VALUES (294, 'Conlan says he is prepared to commit to Rio 2016 ')
GO

INSERT INTO fts_contains_vu_t VALUES (295, 'He said : " It ''s a long way away but I definitely want to win a @ @ @ @ @ @ @ @ @ @ ')
GO

INSERT INTO fts_contains_vu_t VALUES (296, '" The WSB gives a great incentive not to go pro because you get paid for having top fights ')
GO

INSERT INTO fts_contains_vu_t VALUES (297, ' It makes you wonder whether it is really worth turning over ')
GO

INSERT INTO fts_contains_vu_t VALUES (298, ' There ''s not so much money in the pros these days unless you ''re a superstar ')
GO

INSERT INTO fts_contains_vu_t VALUES (299, 'Selby will also stay amateur at least up to next year ''s Commonwealth Games in Glasgow , when he will aim to dispel the dismal memory of his weight-drained , second round defeat to Haroon Khan in Delhi ')
GO

INSERT INTO fts_contains_vu_t VALUES (300, '" I ''ve got unfinished business with the Commonwealths and the fact it ''s in Glasgow makes it something great to aim for , " Selby said ')
GO

INSERT INTO fts_contains_vu_t VALUES (301, '" I want to go there and get a gold , and then it will be time for me to sit down and think about Rio ')
GO

INSERT INTO fts_contains_vu_t VALUES (302, 'At least for the time being , the rivalry between two of the world ''s best amateur flyweight is set to develop ')
GO

INSERT INTO fts_contains_vu_t VALUES (303, ' Thursday night ''s fight will prove who has claimed the upper-hand in the post-London glow ')
GO

INSERT INTO fts_contains_vu_t VALUES (304, '<h> Shakira launches online baby shower')
GO

INSERT INTO fts_contains_vu_t VALUES (305, 'Shakira and her boyfriend Gerard Pique are hosting an online baby shower ')
GO

INSERT INTO fts_contains_vu_t VALUES (306, 'The 35-year-old Columbian singer - who is expecting their first child , a baby boy , to arrive '' '' imminently '' '' - has invited fans to join their virtual charity bash , where they can purchase essential baby gifts that will support UNICEF and benefit some of the world ''s most vulnerable babies ')
GO

INSERT INTO fts_contains_vu_t VALUES (307, 'In an invitation posted on Twitter today ( 16')
GO

INSERT INTO fts_contains_vu_t VALUES (308, '13 ) , the couple wrote : '' '' To celebrate the arrival of our first child , we hope that , in his name , other less privileged children in the world can have their basic needs covered through gifts and donations ')
GO

INSERT INTO fts_contains_vu_t VALUES (309, ' Thank you for sharing this unforgettable moment with us ')
GO

INSERT INTO fts_contains_vu_t VALUES (310, 'The online baby shower engages social media fans by enabling them to join the popstar and her FC Barcelona star beau in their virtual living room , where they can buy '' Inspired Gifts '' such as mosquito nets , polio vaccines and baby-weighing scales @ @ @ @ @ @ @ @ @ @ of the poorest corners of the globe ')
GO

INSERT INTO fts_contains_vu_t VALUES (311, 'Guests are welcomed by a personal video message from Shakira and Gerard ')
GO

INSERT INTO fts_contains_vu_t VALUES (312, 'After purchasing an '' Inspired Gift '' , fans will then receive a personal thank you message from the couple , and be able to view exclusive photos of them taken in December 2012 by Jaume Laiguana ')
GO

INSERT INTO fts_contains_vu_t VALUES (313, 'Shakira has been dating FC Barcelona soccer player Gerard for around two years and previously said he is the '' '' best thing '' '' to ever happen to her , until she got pregnant ')
GO

INSERT INTO fts_contains_vu_t VALUES (314, 'She said : '' '' This man is the best thing that could have happened in my life ')
GO

INSERT INTO fts_contains_vu_t VALUES (315, ' And now the baby ! '' ''')
GO

INSERT INTO fts_contains_vu_t VALUES (316, 'Shakira only confirmed their relationship last year by posting a picture of them both together on Twitter and Facebook with a caption reading , '' '' I present to you my sunshine ')
GO

INSERT INTO fts_contains_vu_t VALUES (317, ' '' '' in Spanish ')
GO

INSERT INTO fts_contains_vu_t VALUES (318, 'The link to the Shakira and Gerard Pique ''s Virtual Baby Shower is here : http : //uni')
GO

INSERT INTO fts_contains_vu_t VALUES (319, 'cf/baby \n')
GO

INSERT INTO fts_contains_vu_t VALUES (320, '<p> ENTREPRENEUR and political activist Declan Ganley has agreed to pay the European Election expenses of Co Louth beef and cereal farmer Raymond O''Malley who failed to get elected , a court was told today ')
GO

INSERT INTO fts_contains_vu_t VALUES (321, 'Mr Ganley , of Moyne Park , Moyne , Abbeyknockmoy , Tuam , Co Galway , had been sued by O''Malley in the Circuit Civil Court for ? 35,366 ')
GO

INSERT INTO fts_contains_vu_t VALUES (322, ' He claimed Ganley had agreed to pay his expenses if he became a Libertas party candidate in the 2009 Euro elections ')
GO

INSERT INTO fts_contains_vu_t VALUES (323, 'Mr Lyons said it had been agreed between the parties that the settlement figure would be paid in two payments between now and the end of February together with an agreed sum towards Mr O''Malley ''s legal costs ')
GO

INSERT INTO fts_contains_vu_t VALUES (324, 'He said that in the event of non-compliance with the settlement terms the defendant would consent to judgment against him ')
GO

INSERT INTO fts_contains_vu_t VALUES (325, 'Judge Linnane , who adjourned the hearing briefly until the terms of settlement were lodged in the court file , put the summary judgment application back for mention on March 6 next ')
GO

INSERT INTO fts_contains_vu_t VALUES (326, 'Neither party @ @ @ @ @ @ @ @ @ @ member of the Irish Farmers Association , polled 18,557 first preference votes in the East Leinster constituency and was eliminated on the third count with 19,396 votes ')
GO

INSERT INTO fts_contains_vu_t VALUES (327, 'Ganley , the founder and chairman of Libertas , last week received an apology and out of court settlement for defamatory comments which were made about him on the social media site , Twitter ')
GO

INSERT INTO fts_contains_vu_t VALUES (328, 'Blogger Kevin Barrington stated he wished to unreservedly apologise to Declan Ganley for his tweets on 12 December 12 , 2012 and stated he had made a substantial donation to the Poor Clare Sisters ')
GO

INSERT INTO fts_contains_vu_t VALUES (329, '<p> Syrian women far outnumber men in the refugee camps in neighboring Jordan ')
GO

INSERT INTO fts_contains_vu_t VALUES (330, ' A new report by the International Rescue Committee says that gender-based violence in Syria is one of the main causes of women fleeing the country , and that reports of rape and violence against women are on the rise ')
GO

INSERT INTO fts_contains_vu_t VALUES (331, ' In a clinic catering to Syrian refugees on the Jordanian border , a psychologist says she is shocked by some of the stories she hears of public rapes and torture ')
GO

INSERT INTO fts_contains_vu_t VALUES (332, 'MELISSA BLOCK , HOST :')
GO

INSERT INTO fts_contains_vu_t VALUES (333, 'You are listening to ALL THINGS CONSIDERED from NPR News ')
GO

INSERT INTO fts_contains_vu_t VALUES (334, 'A recent report by the International Rescue Committee sheds light on an alarming trend in Syria , a surge in sexual violence ')
GO

INSERT INTO fts_contains_vu_t VALUES (335, ' Rape is a significant and disturbing feature of the Syrian war , according to the IRC report , which was based on interviews with hundreds of Syrian refugees in Jordan and Lebanon ')
GO

INSERT INTO fts_contains_vu_t VALUES (336, ' The report includes the stories of a 9-year-old girl who was raped and of a father who shot his own daughter to prevent her from being , in @ @ @ @ @ @ @ @ @ @ in Jordan that provides counseling for some of these victims ')
GO

INSERT INTO fts_contains_vu_t VALUES (337, ' She sent this report ')
GO

INSERT INTO fts_contains_vu_t VALUES (338, 'SHEERA FRENKEL , BYLINE : In a small apartment on a nondescript street in the Jordanian city of Ramthe , Syrian refugees come to get help ')
GO

INSERT INTO fts_contains_vu_t VALUES (339, ' The clinic is run by the International Rescue Committee , and it ''s a place where Syrian refugees share their stories of horror and war ')
GO

INSERT INTO fts_contains_vu_t VALUES (340, 'FRENKEL : The women in the clinic asked that their identities be kept private to protect themselves and their families ')
GO

INSERT INTO fts_contains_vu_t VALUES (341, ' Saher , a 42-year-old mother , comes each week with her 18-month-old baby ')
GO

INSERT INTO fts_contains_vu_t VALUES (342, ' She says she fled Syria when soldiers ransacked her home and put a gun to her infant daughter ''s head ')
GO

INSERT INTO fts_contains_vu_t VALUES (343, 'SAHER : ( Through Translator ) I told them there was no man in the house , so please do n''t come in ')
GO

INSERT INTO fts_contains_vu_t VALUES (344, ' They pushed me down ')
GO

INSERT INTO fts_contains_vu_t VALUES (345, ' I begged for mercy ')
GO

INSERT INTO fts_contains_vu_t VALUES (346, ' They started to say bad words , and I began to cry ')
GO

INSERT INTO fts_contains_vu_t VALUES (347, 'FRENKEL : Saher does n''t say what happened next ')
GO

INSERT INTO fts_contains_vu_t VALUES (348, ' Instead , she speaks about @ @ @ @ @ @ @ @ @ @ SAHER : ( Through Translator ) Yes , there was rape , and they would even kidnap a woman if her relative is a defector ')
GO

INSERT INTO fts_contains_vu_t VALUES (349, ' They would take his sister or his wife ')
GO

INSERT INTO fts_contains_vu_t VALUES (350, ' In Daraa , that really happened ')
GO

INSERT INTO fts_contains_vu_t VALUES (351, 'FRENKEL : Nawall Mohammed is the psychologist who leads the weekly sessions with Saher and others ')
GO

INSERT INTO fts_contains_vu_t VALUES (352, ' Previously , she worked with Iraqi and Palestinian refugees , but she says she ''s never heard stories that affected her as much as those from the Syrian refugees ')
GO

INSERT INTO fts_contains_vu_t VALUES (353, 'NAWALL MOHAMMED : I remember a client ')
GO

INSERT INTO fts_contains_vu_t VALUES (354, ' He is a man , Syrian man ')
GO

INSERT INTO fts_contains_vu_t VALUES (355, ' He said the army , they collect the women , just the women and girls , and they took off their clothes and put them in big cars in the streets in front of their relatives and husbands and brothers naked ')
GO

INSERT INTO fts_contains_vu_t VALUES (356, ' So it is like their weapon ')
GO

INSERT INTO fts_contains_vu_t VALUES (357, 'FRENKEL : Nawall says that the women find it easier to share their stories when they can attribute them to other people ')
GO

INSERT INTO fts_contains_vu_t VALUES (358, ' Some of the stories are about rape by soldiers or security @ @ @ @ @ @ @ @ @ @ that their families have suddenly become refugees ')
GO

INSERT INTO fts_contains_vu_t VALUES (359, ' Melanie Megevand oversees the programs for female refugees for the International Rescue Committee ')
GO

INSERT INTO fts_contains_vu_t VALUES (360, ' In the IRC ''s report , the New York-based NGO revealed that women gave sexual violence as a primary reason for fleeing Syria ')
GO

INSERT INTO fts_contains_vu_t VALUES (361, 'MELANIE MEGEVAND : Given the cultural taboos , particularly in the context of the Middle East , it ''s been extremely telling to hear so many stories of sexual violence occurring and having that being explained by both men and women , including children ')
GO

INSERT INTO fts_contains_vu_t VALUES (362, 'FRENKEL : Saher says that she never thought she would become a refugee , and it scares her to think about what ''s happening back in her hometown of Daraa ')
GO

INSERT INTO fts_contains_vu_t VALUES (363, ' She says she ''s heard from neighbors that her home has been destroyed ')
GO

INSERT INTO fts_contains_vu_t VALUES (364, ' She ''s thankful that she got her family out in time ')
GO

INSERT INTO fts_contains_vu_t VALUES (365, 'SAHER : ( Through Translator ) We only have our own dignity ')
GO

INSERT INTO fts_contains_vu_t VALUES (366, ' A house is a minor thing , but our dignity is a basic thing ')
GO

INSERT INTO fts_contains_vu_t VALUES (367, ' That ''s the reason that pushed us to come to Jordan ')
GO

INSERT INTO fts_contains_vu_t VALUES (368, ' @ @ @ @ @ @ @ @ @ @ Daraa and rebuild one day ')
GO

INSERT INTO fts_contains_vu_t VALUES (369, ' For now , she just wants to focus on getting better ')
GO

INSERT INTO fts_contains_vu_t VALUES (370, ' For NPR News , I ''m Sheera Frenkel ')
GO

INSERT INTO fts_contains_vu_t VALUES (371, 'NPR transcripts are created on a rush deadline by a contractor for NPR , and accuracy and availability may vary ')
GO

INSERT INTO fts_contains_vu_t VALUES (372, ' This text may not be in its final form and may be updated or revised in the future ')
GO

INSERT INTO fts_contains_vu_t VALUES (373, ' Please be aware that the authoritative record of NPR ''s programming is the audio ')
GO

INSERT INTO fts_contains_vu_t VALUES (374, '<h> Published byStanford Medicine')
GO

INSERT INTO fts_contains_vu_t VALUES (375, 'Past studies show that maintaining strong social relationships can lower a person ''s risk for certain health conditions ')
GO

INSERT INTO fts_contains_vu_t VALUES (376, ' But researchers are still working to unravel the mystery about how having an active social life , or the lack of one , can influence physical health ')
GO

INSERT INTO fts_contains_vu_t VALUES (377, 'Findings from two related studies recently presented at the annual meeting of the Society for Personality and Social Psychology offer new insights into how loneliness can weaken the immune system , increase sensitivity to physical pain and contribute to inflammation in the body ')
GO

INSERT INTO fts_contains_vu_t VALUES (378, 'One study looked at overweight but otherwise healthy middle-aged adults , while the second evaluated breast cancer survivors ')
GO

INSERT INTO fts_contains_vu_t VALUES (379, ' In both studies , participants completed stress tests , provided blood samples and had their social lives evaluated using the UCLA Loneliness Scale ')
GO

INSERT INTO fts_contains_vu_t VALUES (380, 'The loneliest of the otherwise healthy participants had more markers of inflammation when tasked with a stressful activity , like speaking in front of others or doing math ')
GO

INSERT INTO fts_contains_vu_t VALUES (381, 'The lonelier breast cancer survivors , in addition to increased inflammation , experienced more pain , @ @ @ @ @ @ @ @ @ @ , which tends to be triggered by stress , can also be used a measure of immune response ')
GO

INSERT INTO fts_contains_vu_t VALUES (382, ' Here , those who scored higher for loneliness showed more signs of herpes reactivation ')
GO

INSERT INTO fts_contains_vu_t VALUES (383, 'Researchers say the results suggest that being lonely can cause people to experience daily life as more stressful , which may cause chronic stress and in turn disrupt the immune system ')
GO

INSERT INTO fts_contains_vu_t VALUES (384, 'The findings related to breast cancer survivors reminded me of research ( subscription required ) by Stanford psychiatrist David Spiegel , MD , on depression and survival rates among this group ')
GO

INSERT INTO fts_contains_vu_t VALUES (385, ' Spiegel discussed his findings and the physiological connection between depression and breast cancer in this past Scope Q&amp;A')
GO

INSERT INTO fts_contains_vu_t VALUES (386, '<h> The Bay Bridge')
GO

INSERT INTO fts_contains_vu_t VALUES (387, 'A SurfboardEtc ')
GO

INSERT INTO fts_contains_vu_t VALUES (388, 'A Jar of Jam')
GO

INSERT INTO fts_contains_vu_t VALUES (389, 'An iPhoneAn Opera')
GO

INSERT INTO fts_contains_vu_t VALUES (390, 'The Making Of ')
GO

INSERT INTO fts_contains_vu_t VALUES (391, ' The Digital El Camino Real')
GO

INSERT INTO fts_contains_vu_t VALUES (392, 'Mission Dolores , San Francisco , established 1776 on El Camino Real ')
GO

INSERT INTO fts_contains_vu_t VALUES (393, 'Traverse the 600-mile trail that connects California ''s 21 missions ')
GO

INSERT INTO fts_contains_vu_t VALUES (394, ' Peer behind an ornate mission altarpiece that , for more than two centuries , has hidden murals painted by the Ohlone Indians ')
GO

INSERT INTO fts_contains_vu_t VALUES (395, ' Uncover the mysteries of Mission Dolores '' ancient cemetery ')
GO

INSERT INTO fts_contains_vu_t VALUES (396, 'CyArk , a non-profit digital scanning company based in Oakland , is creating the digital El Camino Real , documenting some of the oldest buildings and historic sites in California ')
GO

INSERT INTO fts_contains_vu_t VALUES (397, 'LISTEN')
GO

INSERT INTO fts_contains_vu_t VALUES (398, 'Like Interstate 101 " Some people think the Camino Real means the Royal Road of Jesus in California , " says Andrew Galvan , curator of Mission Dolores , San Francisco ')
GO

INSERT INTO fts_contains_vu_t VALUES (399, ' " No ')
GO

INSERT INTO fts_contains_vu_t VALUES (400, ' It was the King ''s Highway , the King of Spain ''s highway ')
GO

INSERT INTO fts_contains_vu_t VALUES (401, 'Mission Dolores , founded in 1776 , is the oldest surviving structure in San Francisco and @ @ @ @ @ @ @ @ @ @ Real to be scanned and documented by CyArk ')
GO

INSERT INTO fts_contains_vu_t VALUES (402, '" If you step out the front door of Mission Dolores you are on the El Camino Real , " says Andrew ')
GO

INSERT INTO fts_contains_vu_t VALUES (403, ' " It was a public road , like Interstate 101 ')
GO

INSERT INTO fts_contains_vu_t VALUES (404, ' All the California Missions are connected ')
GO

INSERT INTO fts_contains_vu_t VALUES (405, ' Wherever you got on it , the road led you to the Viceroy ''s Palace in Mexico City ')
GO

INSERT INTO fts_contains_vu_t VALUES (406, 'CyArk ''s Laser Scanning MissionCyArk has digitally preserved over 70 sites around the world from Pompeii in Italy , to Tikal in Guatemala ')
GO

INSERT INTO fts_contains_vu_t VALUES (407, '" We use a 3 D laser scanner that sends out a pulsed laser beam and captures billions of points of these structures at a rate of about 100,000 points a second , " explains Elizabeth Lee who directs operations at CyArk ')
GO

INSERT INTO fts_contains_vu_t VALUES (408, ' These sites are at risk , endangered due to everyday exposure to the elements , vandalism , war , urbanization , poorly managed tourism , catastrophic events , and general neglect ')
GO

INSERT INTO fts_contains_vu_t VALUES (409, 'The non profit organization was founded in 2003 by Ben and Barbara Kacyra after they sold their technology @ @ @ @ @ @ @ @ @ @ imaging , mapping , modeling , and CAD system which is currently used worldwide in architecture , engineering and construction , entertainment and crime forensics ')
GO

INSERT INTO fts_contains_vu_t VALUES (410, '" It was right at the time that the Bamiyam Buddhas were blown up by the Taliban , " remembers Barbara Kacyra ')
GO

INSERT INTO fts_contains_vu_t VALUES (411, ' " There was no 3 dimensional documentation of them ')
GO

INSERT INTO fts_contains_vu_t VALUES (412, ' We said , '' How can we use this technology to help architects , archaeologists , and preservationists get better tools than tape measures and a clip boards and a pencils to go in and document these heritage sites ')
GO

INSERT INTO fts_contains_vu_t VALUES (413, 'Hidden Mural Revealed')
GO

INSERT INTO fts_contains_vu_t VALUES (414, 'Historic carved altarpiece from Mexico installed in front of mural painted by Indians ')
GO

INSERT INTO fts_contains_vu_t VALUES (415, 'Sometimes new things are revealed during the scanning process ')
GO

INSERT INTO fts_contains_vu_t VALUES (416, ' At Mission Dolores , CyArk worked hard to get behind the very ornately carved reredos , a false wall in back of the altar that was made in Mexico and shipped to the Mission by boat in 1796 ')
GO

INSERT INTO fts_contains_vu_t VALUES (417, ' For more than 200 years , the reredos has obscured a mural that was painted by the Indians when the mission @ @ @ @ @ @ @ @ @ @ a two foot space behind the frame where the statues are today , " says Andrew ')
GO

INSERT INTO fts_contains_vu_t VALUES (418, ' " Very few have ever been able to see what ''s behind ')
GO

INSERT INTO fts_contains_vu_t VALUES (419, ' Using fiber optics they ''ll be able to get a little pin wheel and be able to photograph ')
GO

INSERT INTO fts_contains_vu_t VALUES (420, ' Then you ''ll be able to click on say Saint Joachim with your smart phone and boom ! You ''ll be able to see behind , floor to ceiling , the mural that the Indians painted here at Mission Dolores ')
GO

INSERT INTO fts_contains_vu_t VALUES (421, '" It ''s not about the sites themselves , " says Barbara Kacyra , " It ''s really about the stories ')
GO

INSERT INTO fts_contains_vu_t VALUES (422, ' Whether it was Manzanar or Angor Wat , or Pompeii ')
GO

INSERT INTO fts_contains_vu_t VALUES (423, ' It ''s about the humanness of these sites ')
GO

INSERT INTO fts_contains_vu_t VALUES (424, 'The History of San Francisco')
GO

INSERT INTO fts_contains_vu_t VALUES (425, 'There are almost 6000 Indians buried in the Mission Dolores cemetery , relates Andy Galvan , whose relationship to the Mission is much more than Museum Curator ')
GO

INSERT INTO fts_contains_vu_t VALUES (426, ' Andrew is an Ohlone Indian whose ancestors were some of the first people baptized , married and buried at the Mission Dolores @ @ @ @ @ @ @ @ @ @ the gravemarkers you ''re going to read the history of San Francisco , " he says ')
GO

INSERT INTO fts_contains_vu_t VALUES (427, ' " The 21 California missions are cultural heritage sites ')
GO

INSERT INTO fts_contains_vu_t VALUES (428, ' These are our monuments ')
GO

INSERT INTO fts_contains_vu_t VALUES (429, ' The Digital El Camino Real is about digitally imagining , about preservation ')
GO

INSERT INTO fts_contains_vu_t VALUES (430, ' But it ''s also about interpretation ')
GO

INSERT INTO fts_contains_vu_t VALUES (431, ' It ''s about what happened at the California Missions ')
GO

INSERT INTO fts_contains_vu_t VALUES (432, 'Andy Galvan ''s Ohlone Indian ancestors are buried in the cemetery at Mission Dolores ')
GO

INSERT INTO fts_contains_vu_t VALUES (433, 'MORE POSTS ABOUT')
GO

INSERT INTO fts_contains_vu_t VALUES (434, 'The Making Of ')
GO

INSERT INTO fts_contains_vu_t VALUES (435, ' was part of a public radio experiment called Localore -- 10 independent producers collaborating with 10 public radio stations around the nation , creating some of the new public radio programming of the future ')
GO

INSERT INTO fts_contains_vu_t VALUES (436, ' During this year long collaboration we explored The Making of ')
GO

INSERT INTO fts_contains_vu_t VALUES (437, ' Read More')
GO

INSERT INTO fts_contains_vu_t VALUES (438, 'Recent Posts')
GO

INSERT INTO fts_contains_vu_t VALUES (439, 'The Making Of ')
GO

INSERT INTO fts_contains_vu_t VALUES (440, ' is produced by the Kitchen Sisters and KQED as part of Localore , a nationwide production of AIR , the Association of Independents in Radio with funding from the Corporation for Public Broadcasting ')
GO

INSERT INTO fts_contains_vu_t VALUES (441, '<h> MPAA Lobbies For Army Of Hollywood Drones')
GO

INSERT INTO fts_contains_vu_t VALUES (442, 'You might not imagine the Motion Picture Association of America ( MPAA ) as a particularly drone-happy group , but new documents reveal that the actively lobbying the US government for UAV drone use in domestic space ')
GO

INSERT INTO fts_contains_vu_t VALUES (443, ' No , they are n''t building an army to track down pirates ; they just want filmmakers to be able to shoot with them ')
GO

INSERT INTO fts_contains_vu_t VALUES (444, 'Howard Gantman , a spokesman for the MPAA , argues that drones are safer , cheaper and easier to use for aerial shots than helicopters or cranes , and can be super useful for particularly crazy shots ')
GO

INSERT INTO fts_contains_vu_t VALUES (445, ' Sure , some filmmakers are already using unmanned aerial vehicles for filming , but the legality of the issue is something of a grey area ')
GO

INSERT INTO fts_contains_vu_t VALUES (446, ' The MPAA is pushing the FAA for full-on allowance of the practice so it can really " take-off " so to speak ')
GO

INSERT INTO fts_contains_vu_t VALUES (447, 'The main argument against this is that widespread commercial drone use could lead to all kinds of domestic spying , a privilege the government might like to @ @ @ @ @ @ @ @ @ @ , are already working on laws to prevent exactly the sort of drone use the MPAA is lobbying for ')
GO

INSERT INTO fts_contains_vu_t VALUES (448, 'Commercial drone use is a big can of worms , inside and outside of the movie industry ')
GO

INSERT INTO fts_contains_vu_t VALUES (449, ' Currently , the FAA plans on starting to issue private drone licences by 2015 , but it still has to work out the details of who should be allowed to get them ')
GO

INSERT INTO fts_contains_vu_t VALUES (450, ' If the MPAA has anything to say about it , filmmakers will definitely be on that list ')
GO

INSERT INTO fts_contains_vu_t VALUES (451, ' While they ''re at it , maybe they could put in a good word for fast-food delivery drones too ')
GO

INSERT INTO fts_contains_vu_t VALUES (452, ' The Hill via Fast Company')
GO

INSERT INTO fts_contains_vu_t VALUES (453, 'Just because there is a picture of a Predator ( or similar ) in the story does n''t mean that the studios want military drones ')
GO

INSERT INTO fts_contains_vu_t VALUES (454, ' These beasts are not necessarily cheap nor efficient for what they want ')
GO

INSERT INTO fts_contains_vu_t VALUES (455, ' ( Though they Do have a lower hourly rate than a Cessna or Jetranger , but their purchase cost is higher ( Typically POA ) than a small GA fixed wing ')
GO

INSERT INTO fts_contains_vu_t VALUES (456, ' ( More in the @ @ @ @ @ @ @ @ @ @ Just an RC plane used for commercial purposes ')
GO

INSERT INTO fts_contains_vu_t VALUES (457, 'The name drone actually means a dumb worker ( as in drone bee ')
GO

INSERT INTO fts_contains_vu_t VALUES (458, 'People somehow have only associated the word with semi-autonomous killer drones ( which are actually usually manually piloted , which is why they tend to crash all the time ')
GO

INSERT INTO fts_contains_vu_t VALUES (459, ' ( let the computer do the flying and all will be fine ')
GO

INSERT INTO fts_contains_vu_t VALUES (460, 'The USA has pretty restrictive laws on flying uninhabited aircraft ')
GO

INSERT INTO fts_contains_vu_t VALUES (461, ' ( as did most of the rest of the world ) generally it is only legal to fly these beauties ( big or small ) for hobby purposes ')
GO

INSERT INTO fts_contains_vu_t VALUES (462, 'In Australia , if the aircraft is : Away from residential areas , Below 400 feet above the ground ( yep I know that is fairly low ) Within eyesight of the operator Under 150 kg weight ( but getting clearance from the MAAA for over 50kg is a bit hard )')
GO

INSERT INTO fts_contains_vu_t VALUES (463, 'There are NO rules ')
GO

INSERT INTO fts_contains_vu_t VALUES (464, ' BUT ')
GO

INSERT INTO fts_contains_vu_t VALUES (465, 'Your Insurance company is unlikely to offer cover , therefore actually having a viable business using such craft @ @ @ @ @ @ @ @ @ @ )')
GO

INSERT INTO fts_contains_vu_t VALUES (466, 'Also , putting professional cameras on a Quad , it will need to be a fairly large quad , and the batteries will sort of run out pretty quick ')
GO

INSERT INTO fts_contains_vu_t VALUES (467, ' Better using a 4m fixed wing or 3 metre heli ')
GO

INSERT INTO fts_contains_vu_t VALUES (468, '( If the above rules are met , there is no regulation in Australia ( Check out the CASA website , they say it in as few words ')
GO

INSERT INTO fts_contains_vu_t VALUES (469, 'But if you want to operate outside these regulations , you need to jump through lots of hoops ')
GO

INSERT INTO fts_contains_vu_t VALUES (470, 'Trending Stories Right Now')
GO

INSERT INTO fts_contains_vu_t VALUES (471, 'My initial reaction to Apple ''s expensive new iPhone battery case was in step with the everyone else ''s ')
GO

INSERT INTO fts_contains_vu_t VALUES (472, ' It looks like it has a tumour ')
GO

INSERT INTO fts_contains_vu_t VALUES (473, ' But what I discovered after using it for a full day is it ''s actually surprisingly great ')
GO

INSERT INTO fts_contains_vu_t VALUES (474, 'You might ''ve seen Zaha Hadid ''s name in the news after Japan ''s Sports Council announced a design to her replace her widely loathed and alien-like Olympic stadium in Tokyo ')
GO

INSERT INTO fts_contains_vu_t VALUES (475, ' But the real update comes in the form of a new skyscraper in @ @ @ @ @ @ @ @ @ @ earplug ?')
GO

INSERT INTO fts_contains_vu_t VALUES (476, 'The droids in the Star Wars universe often play a key role in the movies ')
GO

INSERT INTO fts_contains_vu_t VALUES (477, ' But how close are they to some of the real robots in our own universe ? Professor Jonathan Roberts from the Queensland University of Technology drops his science on those assembled ')
GO

INSERT INTO fts_contains_vu_t VALUES (478, '<h> Mum ''s fight over dog mess on pavements')
GO

INSERT INTO fts_contains_vu_t VALUES (479, 'Get daily news by email')
GO

INSERT INTO fts_contains_vu_t VALUES (480, 'Invalid e-mailThanks for subscribing ! Could not subscribe , try again later')
GO

INSERT INTO fts_contains_vu_t VALUES (481, 'Mary Patel')
GO

INSERT INTO fts_contains_vu_t VALUES (482, 'A frustrated mum is on a one-woman mission to stop dogs littering the streets -- by spray-painting their mess ')
GO

INSERT INTO fts_contains_vu_t VALUES (483, 'Mary Patel , 33 , has been scouring the pavements of Gorse Hill in Stretford to highlight the problem by spraying dog muck with biodegradable yellow paint ')
GO

INSERT INTO fts_contains_vu_t VALUES (484, 'Mary believes the problem is out of control on the streets and in parks , and is determined to do something about it ')
GO

INSERT INTO fts_contains_vu_t VALUES (485, 'The mum-of-one said : " I ''ve lived in Gorse Hill for seven years and I really like the area ')
GO

INSERT INTO fts_contains_vu_t VALUES (486, ' Lots of kids play out in the street but they ''re having to play among the dog poo ')
GO

INSERT INTO fts_contains_vu_t VALUES (487, ' I have a 10-month-old baby , Elsie , and in the future I want her to be able to go to the park and walk along the street without swerving the mess ')
GO

INSERT INTO fts_contains_vu_t VALUES (488, 'Mary came up with the idea @ @ @ @ @ @ @ @ @ @ up , then spent weeks searching for biodegradable paint ')
GO

INSERT INTO fts_contains_vu_t VALUES (489, 'So far she has painted 30 piles of waste and intends to keep up her canine campaign ')
GO

INSERT INTO fts_contains_vu_t VALUES (490, 'She added : " I want other people to see it where it is so we can try to say to dog owners , '' we do notice , people are frustrated by it '' ')
GO

INSERT INTO fts_contains_vu_t VALUES (491, 'Peter Molyneux , from Trafford council , said : ? " The council is aware of specific problems in the Gorse Hill area and have patrols out targeting the area in an effort to crack down on the perpetrators of this anti-social behaviour ')
GO

INSERT INTO fts_contains_vu_t VALUES (492, 'Our newspapers include the flagship Manchester Evening News - Britain ''s largest circulating regional daily with up to 130,485 copies - as well as 20 local weekly titles across Greater Manchester , Cheshire and Lancashire ')
GO

INSERT INTO fts_contains_vu_t VALUES (493, 'Free morning newspaper , The Metro , published every weekday , is also part of our portfolio , delivering more than 200,000 readers in Greater Manchester ')
GO

INSERT INTO fts_contains_vu_t VALUES (494, 'Greater Manchester Business Week is the region ''s number one provider of @ @ @ @ @ @ @ @ @ @ 12,687 copies every Thursday ')
GO

INSERT INTO fts_contains_vu_t VALUES (495, 'Every month , M')
GO

INSERT INTO fts_contains_vu_t VALUES (496, ' Media ''s print products reach 2')
GO

INSERT INTO fts_contains_vu_t VALUES (497, '2 million adults , spanning from Accrington in the north to Macclesfield in the south ')
GO

INSERT INTO fts_contains_vu_t VALUES (498, '<h> IPPC to investigate case of autistic teenager arrested by Merseyside police officers who assumed she was drunk')
GO

INSERT INTO fts_contains_vu_t VALUES (499, 'MERSEYSIDE police will be investigated after officers mistakenly arrested an autistic teenage girl for being drunk ')
GO

INSERT INTO fts_contains_vu_t VALUES (500, 'Shares')
GO

INSERT INTO fts_contains_vu_t VALUES (501, 'Get daily news by email')
GO

INSERT INTO fts_contains_vu_t VALUES (502, 'Invalid e-mailThanks for subscribing ! Could not subscribe , try again later')
GO

INSERT INTO fts_contains_vu_t VALUES (503, 'IPPC to investigate case of autistic teenager arrested by Merseyside police officers who assumed she was drunk')
GO

INSERT INTO fts_contains_vu_t VALUES (504, 'MERSEYSIDE police will be investigated after officers mistakenly arrested an autistic teenage girl for being drunk ')
GO

INSERT INTO fts_contains_vu_t VALUES (505, 'Melissa Jones , 17 , was charged with being drunk and disorderly despite suffering with communication problems as part of her condition ')
GO

INSERT INTO fts_contains_vu_t VALUES (506, 'Merseyside police has referred the matter to the Independent Police Complaints Commission ( IPCC ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (507, 'The force said it would also look into the handing of the case ')
GO

INSERT INTO fts_contains_vu_t VALUES (508, 'A spokesman said it would be reviewing the case to see " if there are any lessons to be learned " ')
GO

INSERT INTO fts_contains_vu_t VALUES (509, 'College student Melissa , who was 16 at the time , spent the night in @ @ @ @ @ @ @ @ @ @ DNA taken after she intervened in a brawl in which she ended up being assaulted ')
GO

INSERT INTO fts_contains_vu_t VALUES (510, 'Police issued Melissa with a fixed penalty notice , but she appealed against it and appeared before court in November last year , where she was formally charged with being drunk and disorderly ')
GO

INSERT INTO fts_contains_vu_t VALUES (511, 'A trial was due to be held next month , but Melissa was told last week that the CPS were dropping the case due to " insufficient evidence " ')
GO

INSERT INTO fts_contains_vu_t VALUES (512, 'Her mum , Christine Evans , 49 , told the ECHO : " She should never have been arrested in the first place , let alone charged with drunk and disorderly ')
GO

INSERT INTO fts_contains_vu_t VALUES (513, '" She was upset after being beaten up , so when the police arrested her she became hysterical because she knew she had n''t done anything wrong ')
GO

INSERT INTO fts_contains_vu_t VALUES (514, 'Melissa had been to a shop with friends , near her home in Wavertree , shortly before midnight on June 16 last year , to buy soft drinks ')
GO

INSERT INTO fts_contains_vu_t VALUES (515, 'A drunken woman entered the shop , in Smithdown Road , and became aggressive when @ @ @ @ @ @ @ @ @ @ her friends were attacked when they tried to intervene ')
GO

INSERT INTO fts_contains_vu_t VALUES (516, ' Both girls were stamped on and suffered severe bruising ')
GO

INSERT INTO fts_contains_vu_t VALUES (517, 'Christine said : " This woman had been kicking another girl in the head ')
GO

INSERT INTO fts_contains_vu_t VALUES (518, ' Melissa thought she was going to kill her , so she jumped in and the woman turned on her ')
GO

INSERT INTO fts_contains_vu_t VALUES (519, '" I ran to the shop and told the police Melissa had n''t touched a drop -- she ''s a good girl , but her autism means she ca n''t communicate the way we do ')
GO

INSERT INTO fts_contains_vu_t VALUES (520, 'Christine said Melissa ''s ordeal with the police and going to court had affected her daughter so badly she has needed counselling ever since ')
GO

INSERT INTO fts_contains_vu_t VALUES (521, 'She added : " Melissa has been through hell for the last six months , she ''s even tried to kill herself over this ')
GO

INSERT INTO fts_contains_vu_t VALUES (522, 'A Merseyside Police spokesman said : " A 16- year-old girl was arrested on suspicion of being drunk and disorderly following a disturbance in a shop ')
GO

INSERT INTO fts_contains_vu_t VALUES (523, ' She was taken to a police station , examined by a doctor , and interviewed when @ @ @ @ @ @ @ @ @ @ and released ')
GO

INSERT INTO fts_contains_vu_t VALUES (524, '" The Crown Prosecution Service later made a decision not to continue with the case ')
GO

INSERT INTO fts_contains_vu_t VALUES (525, 'Send a story')
GO

INSERT INTO fts_contains_vu_t VALUES (526, 'Advertising Department')
GO

INSERT INTO fts_contains_vu_t VALUES (527, 'Trinity Mirror Merseyside , the Echo ''s parent company , is one of the North West ''s largest multimedia providers reaching more than 900,000 adults every month ')
GO

INSERT INTO fts_contains_vu_t VALUES (528, 'The Liverpool Echo , Trinity Mirror Merseyside ''s flagship brand , is the area ''s best-read newspaper including national newspapers ')
GO

INSERT INTO fts_contains_vu_t VALUES (529, 'The Liverpool Echo reaches 1 in 3 people in the area with a daily readership of more than 256,000* people')
GO

INSERT INTO fts_contains_vu_t VALUES (530, 'The Liverpool Echo website reaches 1')
GO

INSERT INTO fts_contains_vu_t VALUES (531, '5 million unique users each month who look at around 8')
GO

INSERT INTO fts_contains_vu_t VALUES (532, '5 million pages** ')
GO

INSERT INTO fts_contains_vu_t VALUES (533, 'The Editor')
GO

INSERT INTO fts_contains_vu_t VALUES (534, 'Alastair Machray')
GO

INSERT INTO fts_contains_vu_t VALUES (535, 'Alastair Machray was appointed editor of The Liverpool Echo in 2005 and is also editor-in-chief of Trinity Mirror Merseyside , Cheshire and North Wales ')
GO

INSERT INTO fts_contains_vu_t VALUES (536, ' He is a former editor of The Daily Post ( Wales and England ) and editor-in-chief of the company ''s Welsh operations ')
GO

INSERT INTO fts_contains_vu_t VALUES (537, ' Married dad-of-two and keen golfer Alastair is one of the longest-serving newspaper editors in the country ')
GO

INSERT INTO fts_contains_vu_t VALUES (538, ' His @ @ @ @ @ @ @ @ @ @ ')
GO

INSERT INTO fts_contains_vu_t VALUES (539, '<p> North America ''s population in the 19th century spread from east to west , driven in the main by farming ')
GO

INSERT INTO fts_contains_vu_t VALUES (540, ' And where farmers planted themselves , so grew a demand for farm credit , and eastern bankers followed them ')
GO

INSERT INTO fts_contains_vu_t VALUES (541, 'Drought and crop failure repeatedly parched farmers '' credit , and their bankers '' , and when fresh credit got tough to get , the farmers turned to government for help ')
GO

INSERT INTO fts_contains_vu_t VALUES (542, ' Here , farm economics and politics led to the 1920s '' Canadian Farm Loan Board , created to offer mortgages to respond to a perceived lack of credit for Western farmers ')
GO

INSERT INTO fts_contains_vu_t VALUES (543, 'The Farm Credit Corporation replaced the board in 1959 , with a broader mandate that included consulting services for farmers ')
GO

INSERT INTO fts_contains_vu_t VALUES (544, ' The former board operated mostly on a for-profit basis , but FCC ''s lending rate was set at 5% , well below profitability , amounting to an interest rate subsidy to farmers ')
GO

INSERT INTO fts_contains_vu_t VALUES (545, ' By the 1970s , as the corporation ''s losses mounted , interest rates were set at " the cost of funds plus 1')
GO

INSERT INTO fts_contains_vu_t VALUES (546, '@ @ @ @ @ @ @ @ @ @ Farm Credit Corporation Act ')
GO

INSERT INTO fts_contains_vu_t VALUES (547, ' The new Act allowed FCC to finance farm-related enterprises , and bigger farms ')
GO

INSERT INTO fts_contains_vu_t VALUES (548, ' It did not limit FCCs activities to filling gaps left by the private sector ')
GO

INSERT INTO fts_contains_vu_t VALUES (549, ' These steps -- the shift from for-profit to subsidized farm credit , and the expansion to areas where there was no clear market failure -- signaled departure from FCC ''s original credit-gap mandate ')
GO

INSERT INTO fts_contains_vu_t VALUES (550, ' Changes in 2001 allowed FCC to offer more of financial and business management services , and widened FCC ''s potential clientele to include more farm-related businesses , including those not farmer-owned ')
GO

INSERT INTO fts_contains_vu_t VALUES (551, ' And FCC has seen tremendous growth : Its share of farm debt grew from about 14% in 1992 to 29% by the end of 2011 ')
GO

INSERT INTO fts_contains_vu_t VALUES (552, 'FCC ''s share of farm debt stands against that of all chartered banks , which hold 36% , and all credit unions , which hold another 16% ')
GO

INSERT INTO fts_contains_vu_t VALUES (553, ' FCC has expanded its activities , enlarged its capital base to do so , and built market in a field where the private sector is historically competitive ')
GO

INSERT INTO fts_contains_vu_t VALUES (554, 'FCC ''s success owes much to its @ @ @ @ @ @ @ @ @ @ government , and it borrows directly from the federal government on terms that reflect Ottawa ''s credit quality ')
GO

INSERT INTO fts_contains_vu_t VALUES (555, ' It does not face the same regulatory capital requirements as other financial institutions , and pays no corporate income tax ')
GO

INSERT INTO fts_contains_vu_t VALUES (556, ' And FCC ''s loan offerings and terms are different from others '' ')
GO

INSERT INTO fts_contains_vu_t VALUES (557, ' FCC loans tend to have long amortization periods , higher loan-to-value ratios , and the corporation stands at least as ready as others to lend against supply management ( dairy and poultry farm ) quotas and to offer interest-only loans ')
GO

INSERT INTO fts_contains_vu_t VALUES (558, ' It finances farmers who sign Ontario " green energy " supply contacts ')
GO

INSERT INTO fts_contains_vu_t VALUES (559, ' Other offerings seem likely to encourage debt and inflate farm asset values :')
GO

INSERT INTO fts_contains_vu_t VALUES (560, 'The Capacity Builder Loan , to finance quota purchases or livestock , with an option to capitalize interest ( in turn , deeply investing FCC , and federal taxpayers , in maintaining the farm quota system ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (561, 'None of these is inherently inappropriate , but they are risky , in much the same way that so-called subprime mortgage lending is risky ')
GO

INSERT INTO fts_contains_vu_t VALUES (562, ' Loans characterized by low down payments @ @ @ @ @ @ @ @ @ @ early accumulations of interest due , or involve balloon or variable future payments , have a higher default rate than more traditional loans ')
GO

INSERT INTO fts_contains_vu_t VALUES (563, 'Now , lending under such risky conditions carries an interest rate premium ')
GO

INSERT INTO fts_contains_vu_t VALUES (564, ' For small business lending , a typical risk premium might be 300 basis points above prime ')
GO

INSERT INTO fts_contains_vu_t VALUES (565, ' Of course , FCC does not charge such a premium and , unsurprisingly , its relatively risky loan books carry an impairment ratio that exceeds its competitors '' ')
GO

INSERT INTO fts_contains_vu_t VALUES (566, ' And risks have been growing alongside farm indebtedness as a percent of net income ( see graph ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (567, 'The implications are simple but serious : FCC competes with private-sector lenders in offering financing services to farmers and others ; its market share has been growing without a regulatory capital constraint ; and farm lending has grown relative to farm income , an indicator of rising risk in the sector ')
GO

INSERT INTO fts_contains_vu_t VALUES (568, ' The increased financial risks also appear on the asset side of farms '' balance sheets ')
GO

INSERT INTO fts_contains_vu_t VALUES (569, ' The values of farms and buildings , and farm quota values , have shown effervescent increases in recent years @ @ @ @ @ @ @ @ @ @ '' total assets ( see graph ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (570, ' And FCC ''s lending has grown even faster than farm asset values ')
GO

INSERT INTO fts_contains_vu_t VALUES (571, 'Of course , credit tends to drive asset prices , and increases tend to be followed by sharp revaluations ')
GO

INSERT INTO fts_contains_vu_t VALUES (572, ' Recent farm debt growth , coupled with FCC ''s aggressive strategies , warrants closer examination by regulators and taxpayers ')
GO

INSERT INTO fts_contains_vu_t VALUES (573, ' The potential impacts are not only related to FCC : Its market pressure pushes private lenders to adjust their own lending standards , to remain competitive ')
GO

INSERT INTO fts_contains_vu_t VALUES (574, 'Canadian regulators need to monitor the situation more closely ')
GO

INSERT INTO fts_contains_vu_t VALUES (575, ' FCC , as is the case for the BDC and EDC , is not formally subject to a prudential regulator ')
GO

INSERT INTO fts_contains_vu_t VALUES (576, ' As a starting place , FCC should be brought under OSFI supervision ')
GO

INSERT INTO fts_contains_vu_t VALUES (577, 'Letters to the editor')
GO

INSERT INTO fts_contains_vu_t VALUES (578, 'Please include your address and daytime telephone number ')
GO

INSERT INTO fts_contains_vu_t VALUES (579, ' We give preference to letters that refer to a particular article by headline , author and date ')
GO

INSERT INTO fts_contains_vu_t VALUES (580, 'If your letter concerns articles in other sections of the National Post , including business articles that appear in the A section , @ @ @ @ @ @ @ @ @ @ and other materials sent to the publisher and accepted for publication remains with the author , but the publisher and its licensees may freely reproduce them in print , electronic and other forms ')
GO

INSERT INTO fts_contains_vu_t VALUES (581, '<h> James Fergusson : Up in the air , North of 60')
GO

INSERT INTO fts_contains_vu_t VALUES (582, 'Up in the air , North of 60')
GO

INSERT INTO fts_contains_vu_t VALUES (583, 'What follows is the third of five excerpts from a newly released e-book , The Canadian Forces in 2025 : Problems and Prospects ')
GO

INSERT INTO fts_contains_vu_t VALUES (584, ' The publication was commissioned by the Strategic Studies Working Group -- a partnership between the Canadian International Council and the Canadian Defence and Foreign Affairs Institute ')
GO

INSERT INTO fts_contains_vu_t VALUES (585, ' In today ''s installment , James Fergusson looks at our Air-Force presence in the Arctic ')
GO

INSERT INTO fts_contains_vu_t VALUES (586, 'The federal government has tasked the Canadian Forces with monitoring , controlling and enforcing Canadian laws and regulations over its Arctic territory and adjacent waters ')
GO

INSERT INTO fts_contains_vu_t VALUES (587, ' In so doing , the government , through its 2008 Canada First Defence Strategy and National Shipbuilding Strategy , has focused particular attention on the Royal Canadian Navy ( RCN ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (588, 'The RCN and Coast Guard will play a major role in enforcing national laws and regulations on fishing , the environment , shipping and smuggling ')
GO

INSERT INTO fts_contains_vu_t VALUES (589, ' However , the major burden will fall on the Royal Canadian Air Force @ @ @ @ @ @ @ @ @ @')
GO

INSERT INTO fts_contains_vu_t VALUES (590, 'Today , the RCAF is a " southern , " overseas Air Force that goes North only when necessary ')
GO

INSERT INTO fts_contains_vu_t VALUES (591, ' Only four Twin Otter aircraft are permanently deployed to the North , at Yellowknife , with Joint Task Force North Headquarters ')
GO

INSERT INTO fts_contains_vu_t VALUES (592, ' They undertake a variety of missions , including search and rescue ( SAR ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (593, 'A small number of CF-18 fighters , deployed at Cold Lake and Bagotville , and assigned to NORAD , are dedicated to the air-sovereignty mission ')
GO

INSERT INTO fts_contains_vu_t VALUES (594, ' Their primary use continues to be to intercept Russian bombers on training missions as they approach Canadian air space ')
GO

INSERT INTO fts_contains_vu_t VALUES (595, ' Four forward operating locations ( FOLs ) , co-located with civilian airports in Yellowknife , Inuvik , Iqaluit and Rankin Inlet were developed in the 1980s for the dispersal of CF-18s to the North ')
GO

INSERT INTO fts_contains_vu_t VALUES (596, ' In addition , the Aurora surveillance and reconnaissance aircraft undertake regular Arctic patrols ')
GO

INSERT INTO fts_contains_vu_t VALUES (597, 'To monitor Canadian and North American air space in the North , the North Warning System ( NWS ) replaced NORAD ''s Distant Early Warning radar line in the 1980s ')
GO

INSERT INTO fts_contains_vu_t VALUES (598, ' It primarily consists of automated @ @ @ @ @ @ @ @ @ @ the Northwest Passage ')
GO

INSERT INTO fts_contains_vu_t VALUES (599, ' Finally , the RCAF operates Canadian Forces Station Alert on the northern tip of Ellesmere Island ')
GO

INSERT INTO fts_contains_vu_t VALUES (600, ' The station performs a signals intelligence function and supports SAR ')
GO

INSERT INTO fts_contains_vu_t VALUES (601, 'It is projected that over the next decade there will be an exponential increase in shipping and resource exploitation activity in the Arctic ')
GO

INSERT INTO fts_contains_vu_t VALUES (602, ' If so , the RCAF will be required to monitor Canada ''s Arctic on a daily basis ')
GO

INSERT INTO fts_contains_vu_t VALUES (603, ' More activity also means an increase in search and rescue demands ')
GO

INSERT INTO fts_contains_vu_t VALUES (604, ' As such , the RCAF will have no choice but to shift resources to the North on a permanent basis ')
GO

INSERT INTO fts_contains_vu_t VALUES (605, 'To meet this demand , the existing FOLs likely will become permanent bases for forward deployed surveillance and reconnaissance and SAR aircraft ')
GO

INSERT INTO fts_contains_vu_t VALUES (606, ' The Aurora , or possibly future unmanned aerial vehicles ( UAVs ) , will play a vital role in monitoring traffic over this expansive area ')
GO

INSERT INTO fts_contains_vu_t VALUES (607, ' Though UAVs can be operated from bases in the south through satellite links , they will still need to be maintained at their bases in the North ')
GO

INSERT INTO fts_contains_vu_t VALUES (608, 'Being cued by the @ @ @ @ @ @ @ @ @ @ will provide tracking of shipping and fishing vessels , the identification of targets of interest , and direction of RCN or Coast Guard vessels for interception purposes ')
GO

INSERT INTO fts_contains_vu_t VALUES (609, ' Permanently deployed SAR aircraft and helicopters will be necessary to provide rapid response to accidents in the North ')
GO

INSERT INTO fts_contains_vu_t VALUES (610, ' In addition , helicopters also will potentially provide a rapid response interception capability ')
GO

INSERT INTO fts_contains_vu_t VALUES (611, 'There is also a slight possibility that the CF-18 or its replacement will need to be permanently deployed to the North ')
GO

INSERT INTO fts_contains_vu_t VALUES (612, ' However , the likelihood that significant military threats will emerge in the Arctic is very low , especially as a function of the harsh environment ')
GO

INSERT INTO fts_contains_vu_t VALUES (613, 'Finally , the North Warning System will likely be expanded northward as part of its future modernization , with all the attendant costs of building new sites ')
GO

INSERT INTO fts_contains_vu_t VALUES (614, 'Currently , the RCAF is developing a northern plan to meet future demand ')
GO

INSERT INTO fts_contains_vu_t VALUES (615, ' Regardless of the details , the costs will be significant ')
GO

INSERT INTO fts_contains_vu_t VALUES (616, ' Building and staffing permanent bases will be expensive , although some costs may be offset by other government departments and agencies in response to increased civilian @ @ @ @ @ @ @ @ @ @ no need to acquire a dedicated Arctic aircraft : The current and planned inventory of multi-role aircraft will be able to meet this requirement ')
GO

INSERT INTO fts_contains_vu_t VALUES (617, ' That will reduce some costs ')
GO

INSERT INTO fts_contains_vu_t VALUES (618, ' However , aircraft and personnel deployed to the North on a permanent basis will impact the ability of the RCAF to meet its other demands ')
GO

INSERT INTO fts_contains_vu_t VALUES (619, 'Costs related to the retention and recruitment of personnel also will be significant ')
GO

INSERT INTO fts_contains_vu_t VALUES (620, ' Canadians may have an emotional attachment to the North , but this does not necessarily mean that RCAF personnel and their families will look forward to being posted there for several years ')
GO

INSERT INTO fts_contains_vu_t VALUES (621, 'In order to meet these costs , the key issue for the RCAF is whether government will be willing to provide the necessary funding ')
GO

INSERT INTO fts_contains_vu_t VALUES (622, ' If not , the RCAF will be strained to the breaking point , which will cascade throughout the organization as it confronts other significant investment demands on its equipment and personnel ')
GO

INSERT INTO fts_contains_vu_t VALUES (623, 'National Post')
GO

INSERT INTO fts_contains_vu_t VALUES (624, 'James Fergusson is a Research Fellow with the Canadian Defence and Foreign Affairs Institute ')
GO

INSERT INTO fts_contains_vu_t VALUES (625, '<h> From Richard III to Johnny Rotten : The changing face of evil Add to ')
GO

INSERT INTO fts_contains_vu_t VALUES (626, 'When Johnny Lydon , then known as Johnny Rotten , took the microphone in front of the Sex Pistols in the late 1970s , he projected a fantastic malevolence ')
GO

INSERT INTO fts_contains_vu_t VALUES (627, ' Skinny , hunched , wide-eyed , a man anger-obsessed ')
GO

INSERT INTO fts_contains_vu_t VALUES (628, ' He also began to affect a strange accent , a hyper-enunciation , with trilled r ''s ( as in " Rrright , now " ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (629, ' It was clearly his own Cockney tinged with something else , a parody of something aristocratic ')
GO

INSERT INTO fts_contains_vu_t VALUES (630, ' Lydon has said in interviews , and in his autobiography , that this stage persona was partly inspired by Laurence Olivier ''s performance of Richard III , in his 1955 film based on the Shakespeare play ')
GO

INSERT INTO fts_contains_vu_t VALUES (631, 'And indeed that is the image -- the twisted , poetic man with murder on his mind -- that we have long had imprinted on us , an image not just of this particular king but of English kings in general ')
GO

INSERT INTO fts_contains_vu_t VALUES (632, ' It was a creation of Shakespeare and of @ @ @ @ @ @ @ @ @ @ Sex Pistols but by Rowan Atkinson in the early Blackadder episodes and even to a certain extent by Jonathan Rhys Meyers as a slender yet savage Henry VIII in The Tudors ')
GO

INSERT INTO fts_contains_vu_t VALUES (633, ' It informed Heath Ledger ''s nastily disfigured Joker character ')
GO

INSERT INTO fts_contains_vu_t VALUES (634, 'Disfigurement -- or simple ugliness -- is key to the persona in all its iterations ')
GO

INSERT INTO fts_contains_vu_t VALUES (635, ' Shakespeare called the king a hunchback ( we now know he had severe scoliosis ) ')
GO

INSERT INTO fts_contains_vu_t VALUES (636, ' He was using a crude and ancient trick of storytelling : Villains , like monsters , are ugly ')
GO

INSERT INTO fts_contains_vu_t VALUES (637, ' They bear some deformity that evinces their evil ')
GO

INSERT INTO fts_contains_vu_t VALUES (638, ' The monster Grendel , Beowulf ''s nemesis , is an " unnatural birth , " larger than a man , his skin covered in a horny iron substance ')
GO

INSERT INTO fts_contains_vu_t VALUES (639, ' Rumpelstiltskin , the evil imp , is the opposite : a dwarf ')
GO

INSERT INTO fts_contains_vu_t VALUES (640, ' Witches and wicked stepmothers have warts and curved noses throughout fairy tales ')
GO

INSERT INTO fts_contains_vu_t VALUES (641, ' The tradition continues through modern science fiction , where alien enemies are usually reptilian , or masked , like Darth Vader -- what horrible visage is the dark lord protecting from sight ? @ @ @ @ @ @ @ @ @ @ Rotten was using to command attention : Ugliness is clever , rebellious , angry ')
GO

INSERT INTO fts_contains_vu_t VALUES (642, ' His ugliness heralded revolution ')
GO

INSERT INTO fts_contains_vu_t VALUES (643, ' And Shakespeare ''s Richard III is similarly complex : His resentment about his deformity motivates him ')
GO

INSERT INTO fts_contains_vu_t VALUES (644, ' Some of the most frightening lines about physical ugliness in English literature come out of his mouth : Deformed , unfinish ''d , sent before my time / Into this breathing world , scarce half made up , And that so lamely and unfashionable / That dogs bark at me as I halt by them ')
GO

INSERT INTO fts_contains_vu_t VALUES (645, ' " Later Queen Margaret describes him as a " poisonous bunchback ''d toad ')
GO

INSERT INTO fts_contains_vu_t VALUES (646, ' " ( He calls her in return a " hateful wither ''d hag ')
GO

INSERT INTO fts_contains_vu_t VALUES (647, ' " Shakespeare did not fear causing offence ')
GO

INSERT INTO fts_contains_vu_t VALUES (648, 'It is hard for anyone with a disability or deformity to read those lines ')
GO

INSERT INTO fts_contains_vu_t VALUES (649, ' I have a minor one myself ( funny hands ) and remember being moved , as a teenager reading this play , by the horror of the dogs as the lame man passes by ')
GO

INSERT INTO fts_contains_vu_t VALUES (650, 'In modern times , interpreters of Shakespeare ''s character @ @ @ @ @ @ @ @ @ @ ')
GO

INSERT INTO fts_contains_vu_t VALUES (651, ' A famous Royal Shakespeare Company show from 1984 had actor Richard Sher playing the king in crutches , barely able to walk ; other companies have used actors with real disabilities to play the king , including at least one in a wheelchair ')
GO

INSERT INTO fts_contains_vu_t VALUES (652, ' The idea , with every new version of the play , is to add to the character ''s complexity , to make him more than a mere psycho ')
GO

INSERT INTO fts_contains_vu_t VALUES (653, 'By the 19th century , the sentimental archetype of the deformed antihero had shifted to a more benevolent one ')
GO

INSERT INTO fts_contains_vu_t VALUES (654, ' Quasimodo , the hunchback of Notre Dame , is an object of sympathy rather than loathing ; a simple victim rather than a complex tyrant ')
GO

INSERT INTO fts_contains_vu_t VALUES (655, ' This is now a convention we are familiar with too , in theatre in particular -- The Phantom of the Opera is also about a disfigured face that needs love ')
GO

INSERT INTO fts_contains_vu_t VALUES (656, 'Even in recent science fiction and fantasy , attempts have been made to break negative expectations of abnormal-looking characters ')
GO

INSERT INTO fts_contains_vu_t VALUES (657, ' Tyrion Lannister , the manipulative genius of Game of Thrones , is a sympathetic dwarf , and as @ @ @ @ @ @ @ @ @ @ has become a sex symbol ')
GO

INSERT INTO fts_contains_vu_t VALUES (658, ' The South African sci-fi film District 9 created a slave race of slimy aliens -- they have tentacles on their faces and are rudely called Prawns -- who are the most sympathetic , and secretly intelligent , characters in the story ')
GO

INSERT INTO fts_contains_vu_t VALUES (659, ' The idea in modern representations is that we the audience all feel abnormal in some way and are going to identify with the mocked and shunned far more than with the powerful ')
GO

INSERT INTO fts_contains_vu_t VALUES (660, ' This idea of individualism is a recent one , a product of the Enlightenment and Romanticism ')
GO

INSERT INTO fts_contains_vu_t VALUES (661, 'Shakespeare ''s textured and interesting Richard III , though , is part of the beginning of that transformation , for disfigured characters in literary history , from monsters to charming victims or even stoic heroes ')
GO

INSERT INTO fts_contains_vu_t VALUES (662, ' Richard , like Johnny Rotten , is dissatisfied with " idle pleasures , " and " determined to be a villain , " and an amusing and charming villain he is ')
GO

INSERT INTO fts_contains_vu_t VALUES (663, ' This was around 1592 -- 75 years before Milton ''s attractively tortured Satan , in Paradise Lost , became a model for sexy villains @ @ @ @ @ @ @ @ @ @ found evidence that the real Richard III was not only actually deformed but that his life of battle was truly an ugly one ')
GO

INSERT INTO fts_contains_vu_t VALUES (664, ' The skeleton found under a parking lot in Leicester showed the results of bound wrists , an axe or sword blow to the head , a sword through the buttocks , and other unnamed " humiliation wounds , " probably inflicted after death ')
GO

INSERT INTO fts_contains_vu_t VALUES (665, ' This king was torn apart by a mob of soldiers , his body publicly defiled and then thrown into an unmarked grave ')
GO

INSERT INTO fts_contains_vu_t VALUES (666, ' The world of violence these guys lived in was ruthless from birth ')
GO

INSERT INTO fts_contains_vu_t VALUES (667, ' One ca n''t really imagine a blameless moral king coming out of this culture ')
GO

INSERT INTO fts_contains_vu_t VALUES (668, ' Plantagenets , Tudors , Sopranos -- all fundamentally depraved family sagas ')
GO

INSERT INTO fts_contains_vu_t VALUES (669, ' We need a scary character -- a face -- to embody the blood thirst of the time ')
GO

INSERT INTO fts_contains_vu_t VALUES (670, 'Creepily , a computer reconstruction of Richard III ''s face , based on the skull recently dug up , bears a very slight resemblance to the young Laurence Olivier''s')
GO

INSERT INTO fts_contains_vu_t VALUES (671, '<h> '' Incompatible with life '' : Mother ''s account of her difficult decision to request a late-term abortion sheds light on '' live-born '' debate')
GO

INSERT INTO fts_contains_vu_t VALUES (672, 'One mother ''s account of her difficult decision to request a rare , late-term abortion')
GO

INSERT INTO fts_contains_vu_t VALUES (673, 'Twenty-one weeks into her second pregnancy , when the fetus was diagnosed with a rare bone disease , Carol determined she had two options : Miscarry the baby naturally and deliver a child with a shattered skeleton that would live for a matter of seconds or request a rare late-term abortion ')
GO

INSERT INTO fts_contains_vu_t VALUES (674, '" I found out when I was five months pregnant , and ')
GO

INSERT INTO fts_contains_vu_t VALUES (675, ' by the time you ''re five months pregnant you ''re all in , " said Carol , not her real name ')
GO

INSERT INTO fts_contains_vu_t VALUES (676, ' " There ''s no great outcome in these situations ')
GO

INSERT INTO fts_contains_vu_t VALUES (677, 'Babies without lungs , kidneys , spines , bones or brains : These are the rare " incompatible with life " conditions that clinicians say prompt most , if not all , of Canada ''s contentious " live born " abortions ')
GO

INSERT INTO fts_contains_vu_t VALUES (678, ' According to Statistics @ @ @ @ @ @ @ @ @ @ and 2009 ')
GO

INSERT INTO fts_contains_vu_t VALUES (679, 'But while three MPs drafted a Jan')
GO

INSERT INTO fts_contains_vu_t VALUES (680, ' 23 letter to the RCMP citing these " live born " abortions as evidence of premeditated " homicide " in Canadian hospitals , clinicians and veterans of the procedure maintain that in Canada , the only fetuses terminated in late-stage abortions are those whose fates are already sealed ')
GO

INSERT INTO fts_contains_vu_t VALUES (681, 'Carol ''s fetus was killed by the procedure , but it was virtually identical to those that result in live births ')
GO

INSERT INTO fts_contains_vu_t VALUES (682, '" I want people to understand what these women have been through before they start accusing the doctors who helped them of being murderers , " said Carol ')
GO

INSERT INTO fts_contains_vu_t VALUES (683, 'In 2010 , 537 Canadian women underwent abortions after 21 weeks of pregnancy , not including Quebec ')
GO

INSERT INTO fts_contains_vu_t VALUES (684, ' According to Wendy Norman , a clinical professor at the University of British Columbia , " almost everyone " in those cases " has some different anomaly ')
GO

INSERT INTO fts_contains_vu_t VALUES (685, 'Some have fetal anencephaly , a condition in which the fetus fails to develop a brain ')
GO

INSERT INTO fts_contains_vu_t VALUES (686, 'Others fail to develop kidneys , a condition known as Potter @ @ @ @ @ @ @ @ @ @')
GO

INSERT INTO fts_contains_vu_t VALUES (687, 'Many times , said Dr')
GO

INSERT INTO fts_contains_vu_t VALUES (688, ' Norman , the specific defect is so rare that it does not even have a proper medical name ')
GO

INSERT INTO fts_contains_vu_t VALUES (689, 'After an ultrasound at 21 weeks , Carol ''s fetus was diagnosed with osteogenesis imperfecta , a genetic disorder that results in severe bone fragility ')
GO

INSERT INTO fts_contains_vu_t VALUES (690, 'Less severe condition are survivable , although they result in physical deformities into adulthood ')
GO

INSERT INTO fts_contains_vu_t VALUES (691, ' Carol ''s fetus , however , had one of the most extreme cases ')
GO

INSERT INTO fts_contains_vu_t VALUES (692, 'If the baby was naturally stillborn , said Carol , she would have needed to select a name , learn the child ''s gender and make funeral arrangements ')
GO

INSERT INTO fts_contains_vu_t VALUES (693, 'Carol requested a late-stage abortion , adding that the procedure was never broached by medical staff , and even finding a physician qualified to perform it was a challenge ')
GO

INSERT INTO fts_contains_vu_t VALUES (694, '" They ''re not offering these things up ')
GO

INSERT INTO fts_contains_vu_t VALUES (695, ' It was n''t even presented as an option , " she said ')
GO

INSERT INTO fts_contains_vu_t VALUES (696, 'If anything , she said , hospital staff made sure to explain why some women will carry a known stillborn to @ @ @ @ @ @ @ @ @ @ birth ')
GO

INSERT INTO fts_contains_vu_t VALUES (697, 'Blogs and online pregnancy forums abound with testimonials from women who carried their children to term with full knowledge that they would not live more than a matter of minutes ')
GO

INSERT INTO fts_contains_vu_t VALUES (698, 'I savored every kick and turn she made inside my growing belly')
GO

INSERT INTO fts_contains_vu_t VALUES (699, '" I savored every kick and turn she made inside my growing belly , " wrote one woman of her decision to carry a fetus with fetal anencephaly to term ')
GO

INSERT INTO fts_contains_vu_t VALUES (700, 'Wrote another woman whose fetus was diagnosed with Potter ''s Syndrome , " I chose to carry to term and made it to 37 1/2 weeks when we had a C-section ')
GO

INSERT INTO fts_contains_vu_t VALUES (701, ' He lived just under three hours , the happiest and saddest hours of my life ')
GO

INSERT INTO fts_contains_vu_t VALUES (702, 'Speaking to the Post in November , Dr')
GO

INSERT INTO fts_contains_vu_t VALUES (703, ' Douglas Black , president of the Society of Obstetricians and Gynaecologists , speculated that similar sentiments may underlie the 491 " live-born " abortions between 2000 and 2009 ')
GO

INSERT INTO fts_contains_vu_t VALUES (704, 'As hospitals will routinely administer a lethal injection to a fetus prior to a later-stage abortion , Dr')
GO

INSERT INTO fts_contains_vu_t VALUES (705, ' Black guessed that any aborted @ @ @ @ @ @ @ @ @ @ due to the " private choice " of a mother ')
GO

INSERT INTO fts_contains_vu_t VALUES (706, 'Such fetuses are " subsequently allowed to pass away , depending on what the circumstances are , sometimes in their mom ''s arms , " he said ')
GO

INSERT INTO fts_contains_vu_t VALUES (707, 'For Carol , there were physical risks of carrying the fetus to term over another four months , but she said it was also a psychological decision ')
GO

INSERT INTO fts_contains_vu_t VALUES (708, '" The idea of having the pain of childbirth compounded by the really emotional trauma of losing a child , it was a lot to take on ')
GO

INSERT INTO fts_contains_vu_t VALUES (709, ' I do n''t think I would have been able to think about having more babies subsequently , " she said ')
GO

INSERT INTO fts_contains_vu_t VALUES (710, ' She has since given birth to a second child in a complications-free pregnancy ')
GO

INSERT INTO fts_contains_vu_t VALUES (711, '<h> Mary Leakey , the '' grande dame of archeology , '' gets a Google celebration for her 100th birthday')
GO

INSERT INTO fts_contains_vu_t VALUES (712, 'Mary Leakey , the '' grande dame of archeology , '' turns 100')
GO

INSERT INTO fts_contains_vu_t VALUES (713, 'Mary Leakey cemented her status as a giant of archeology in 1959 with one confident cry : " I ''ve found him -- I ''ve found our man ! "')
GO

INSERT INTO fts_contains_vu_t VALUES (714, 'She was calling out to her husband , Louis , after coming across a bone protruding from stones during an expedition in Tanzania ')
GO

INSERT INTO fts_contains_vu_t VALUES (715, ' " Her man " was an Australopithecus boisei ape -- about 1')
GO

INSERT INTO fts_contains_vu_t VALUES (716, '8 million years old ')
GO

INSERT INTO fts_contains_vu_t VALUES (717, ' His was the first fossilized skull ever found from the extinct , human-related species ')
GO

INSERT INTO fts_contains_vu_t VALUES (718, 'Leakey , the " grande dame of archeology , " as author Virginia Morrell put it , would have turned 100 Wednesday ')
GO

INSERT INTO fts_contains_vu_t VALUES (719, ' To mark the occasion , Google converted its logo into a tribute to the British archaeologist ')
GO

INSERT INTO fts_contains_vu_t VALUES (720, 'The Australopithecus boisei skull was one of several important discoveries Leakey made in her career -- all made despite the fact that she had nearly @ @ @ @ @ @ @ @ @ @ She got thrown out of school very early on and never wanted to go back , and became hugely interested in archaeology , " Richard Leakey , her son , told Archaeology magazine')
GO

INSERT INTO fts_contains_vu_t VALUES (721, 'She had been working as an illustrator for archeological books , which was how she met her eventual husband , archeologist Louis Leakey ')
GO

INSERT INTO fts_contains_vu_t VALUES (722, 'In their time working together , the couple made significant discoveries in the field , including uncovering the Homo habili " handy man " and , later , the Laetoli Footprints -- which showed human-like walking patterns from 3')
GO

INSERT INTO fts_contains_vu_t VALUES (723, '6 million years ago ')
GO

INSERT INTO fts_contains_vu_t VALUES (724, 'Leakey died in 1996 at the age of 83 ')
GO

INSERT INTO fts_contains_vu_t VALUES (725, ' " She was one of the world ''s great originals , " anatomist Dr')
GO

INSERT INTO fts_contains_vu_t VALUES (726, ' Alan Walker , who had accompanied the Leakey family on expeditions , told the New York Times for her obituary ')
GO

INSERT INTO fts_contains_vu_t VALUES (727, 'She was one of the world ''s great originals')
GO

INSERT INTO fts_contains_vu_t VALUES (728, '" Untrained except in art , she developed techniques of excavation and descriptive archeology and did it all on her own in the middle of Africa , " he added ')
GO

INSERT INTO fts_contains_vu_t VALUES (729, ' " @ @ @ @ @ @ @ @ @ @ death , her family name is still making headlines in the world of archeology ')
GO

INSERT INTO fts_contains_vu_t VALUES (730, ' Just a few months ago , Meave Leakey , Mary ''s daughter-in-law , made news after her team reported finding a new species of humans from two million years ago ')
GO

INSERT INTO fts_contains_vu_t VALUES (731, 'To honour Mary ''s 100th birthday , the Leakey Foundation is encouraging people to donate $100 in her honour to further scientific knowledge of human origins ')
GO

INSERT INTO fts_contains_vu_t VALUES (732, '<h> Indian Railway ''s total earning up by 20%')
GO

INSERT INTO fts_contains_vu_t VALUES (733, 'The total approximate earnings of Indian Railways on originating basis during 1st April 2012 to 31st January 2013 was Rs 101223')
GO

INSERT INTO fts_contains_vu_t VALUES (734, '95 crore compared to Rs 84083')
GO

INSERT INTO fts_contains_vu_t VALUES (735, '74 crore during the same period last year ')
GO

INSERT INTO fts_contains_vu_t VALUES (736, 'TNN Feb 11 , 2013 , 03')
GO

INSERT INTO fts_contains_vu_t VALUES (737, '34 PM IST')
GO

INSERT INTO fts_contains_vu_t VALUES (738, 'MUMBAI : The total approximate earnings of Indian Railways on originating basis during 1st April 2012 to 31st January 2013 was Rs 101223')
GO

INSERT INTO fts_contains_vu_t VALUES (739, '95 crore compared to Rs 84083')
GO

INSERT INTO fts_contains_vu_t VALUES (740, '74 crore during the same period last year , registering an increase of 20')
GO

INSERT INTO fts_contains_vu_t VALUES (741, '38 per cent ')
GO

INSERT INTO fts_contains_vu_t VALUES (742, 'A press release issued by the ministry of railways said , " The total goods earnings have gone up from Rs 56163')
GO

INSERT INTO fts_contains_vu_t VALUES (743, '30 crore during 1st April 2011 - 31st January 2012 to Rs 70067')
GO

INSERT INTO fts_contains_vu_t VALUES (744, '36 crore during 1st April 2012 - 31st January 2013 , registering an increase of 24')
GO

INSERT INTO fts_contains_vu_t VALUES (745, '76 per cent ')
GO

INSERT INTO fts_contains_vu_t VALUES (746, 'The total passenger revenue earnings during 1st April 2012 - 31st January 2013 was Rs 25924')
GO

INSERT INTO fts_contains_vu_t VALUES (747, '29 crore compared to Rs')
GO

INSERT INTO fts_contains_vu_t VALUES (748, ' 23344')
GO

INSERT INTO fts_contains_vu_t VALUES (749, '42 crore during the same period last year , registering an increase of 11')
GO

INSERT INTO fts_contains_vu_t VALUES (750, '05 @ @ @ @ @ @ @ @ @ @ The revenue earnings from other coaching amounted to Rs 2617')
GO

INSERT INTO fts_contains_vu_t VALUES (751, '19 crore during April 2012 - January 2013 compared to Rs 2353')
GO

INSERT INTO fts_contains_vu_t VALUES (752, '54 crore during the same period last year , an increase of 11')
GO

INSERT INTO fts_contains_vu_t VALUES (753, '20 per cent ')
GO

INSERT INTO fts_contains_vu_t VALUES (754, 'The total approximate numbers of passengers booked during 1st April 2012 - 31st January 2013 were 7150')
GO

INSERT INTO fts_contains_vu_t VALUES (755, '60 million compared to 6910')
GO

INSERT INTO fts_contains_vu_t VALUES (756, '00 million during the same period last year , showing an increase of 3')
GO

INSERT INTO fts_contains_vu_t VALUES (757, '48 per cent ')
GO

INSERT INTO fts_contains_vu_t VALUES (758, 'The ministry further said in the suburban and non-suburban sectors , the numbers of passengers booked during April 2012 -January 2013 were 3753')
GO

INSERT INTO fts_contains_vu_t VALUES (759, '32 million and 3397')
GO

INSERT INTO fts_contains_vu_t VALUES (760, '28 million compared to 3651')
GO

INSERT INTO fts_contains_vu_t VALUES (761, '70 million and 3258')
GO

INSERT INTO fts_contains_vu_t VALUES (762, '30 million during the same period last year , showing an increase of 2')
GO

INSERT INTO fts_contains_vu_t VALUES (763, '78 per cent 3')
GO

INSERT INTO fts_contains_vu_t VALUES (764, '48 per cent respectively ')
GO

INSERT INTO fts_contains_vu_t VALUES (765, 'RELATED')
GO

INSERT INTO fts_contains_vu_t VALUES (766, 'From around the web')
GO

INSERT INTO fts_contains_vu_t VALUES (767, 'More from The Times of India')
GO

INSERT INTO fts_contains_vu_t VALUES (768, 'Recommended By Colombia')
GO

INSERT INTO fts_contains_vu_t VALUES (769, 'From Around the Web')
GO

INSERT INTO fts_contains_vu_t VALUES (770, 'More From The Times of India')
GO

INSERT INTO fts_contains_vu_t VALUES (771, 'Recommended By Colombia')
GO

INSERT INTO fts_contains_vu_t VALUES (772, 'Comments')
GO

INSERT INTO fts_contains_vu_t VALUES (773, 'Characters Remaining : 3000')
GO

INSERT INTO fts_contains_vu_t VALUES (774, 'OR PROCEED WITHOUT REGISTRATION')
GO

INSERT INTO fts_contains_vu_t VALUES (775, 'Share on Twitter')
GO

INSERT INTO fts_contains_vu_t VALUES (776, 'SIGN IN WITH')
GO

INSERT INTO fts_contains_vu_t VALUES (777, 'FacebookGoogleEmail')
GO

INSERT INTO fts_contains_vu_t VALUES (778, 'Refrain from posting comments that @ @ @ @ @ @ @ @ @ @ indulge in personal attacks , name calling or inciting hatred against any community ')
GO

INSERT INTO fts_contains_vu_t VALUES (779, ' Help us delete comments that do not follow these guidelines by marking them offensive ')
GO

INSERT INTO fts_contains_vu_t VALUES (780, ' Let ''s work together to keep the conversation civil ')
GO

INSERT INTO fts_contains_vu_t VALUES (781, 'Read more')
GO

INSERT INTO fts_contains_vu_t VALUES (782, 'Most Popular')
GO

INSERT INTO fts_contains_vu_t VALUES (783, 'The external affairs ministry on Wednesday advised Indian students seeking admission in two California-based universities to defer their departure till it gets a response from the US government on the issue ')
GO

INSERT INTO fts_contains_vu_t VALUES (784, '<h> News You Can Use 24 genes enhance the risk of myopia')
GO

INSERT INTO fts_contains_vu_t VALUES (785, 'An unfavourable combination of genetic predisposition and environmental factors appears to be particularly risky for the development of myopia ')
GO

INSERT INTO fts_contains_vu_t VALUES (786, 'Scientists have identified 24 new genes that cause myopia or short-sightedness , a breakthrough that could lead to drugs for prevention of the eye condition from which 80% of Asians suffer ')
GO

INSERT INTO fts_contains_vu_t VALUES (787, 'Myopia is a major cause of blindness and visual impairment worldwide , and currently there is no cure , according to a study published in the journal Nature Genetics ')
GO

INSERT INTO fts_contains_vu_t VALUES (788, ' The study was led by professor Chris Hammond from the department of twin research and genetic epidemiology at King ''s College London ')
GO

INSERT INTO fts_contains_vu_t VALUES (789, ' Researchers analysed the genetic and refractive error data of over 45,000 people from 32 different studies ')
GO

INSERT INTO fts_contains_vu_t VALUES (790, ' The new genes include those which function in brain and eye tissue signalling , the structure of the eye , and eye development ')
GO

INSERT INTO fts_contains_vu_t VALUES (791, ' It was already known that environmental factors , such as reading , lack of outdoor exposure , and a higher level of education can increase the risk @ @ @ @ @ @ @ @ @ @ environmental factors appears to be particularly risky for the development of myopia ')
GO

INSERT INTO fts_contains_vu_t VALUES (792, '" This study reveals for the first time a group of new genes that are associated with myopia and that carriers of some of these genes have a tenfold increased risk of developing the condition , " Prof')
GO

INSERT INTO fts_contains_vu_t VALUES (793, ' Hammond said in a statement ')
GO

INSERT INTO fts_contains_vu_t VALUES (794, '<h> Banks can open A/cs for Bangladeshi nationals sans RBI nod')
GO

INSERT INTO fts_contains_vu_t VALUES (795, 'MUMBAI : The Reserve Bank today said banks are permitted to now open non-resident ordinary rupee ( NRO ) account of Bangladeshi nationals without its prior approval ')
GO

INSERT INTO fts_contains_vu_t VALUES (796, ' it has been decided that henceforth , banks would be permitted to open NRO account of individual/s of Bangladesh nationality without the approval of the Reserve Bank , " it said in a notification ')
GO

INSERT INTO fts_contains_vu_t VALUES (797, 'The permission is granted subject to the conditions the bank should satisfy itself that the individual holds a valid visa and valid residential permit ')
GO

INSERT INTO fts_contains_vu_t VALUES (798, 'The RBI said banks should put in place a system of quarterly reporting whereby each branch of the bank shall maintain a record of the bank accounts opened by individual(s) of Bangladesh nationality and details of such account shall be forwarded to their head office ')
GO

INSERT INTO fts_contains_vu_t VALUES (799, 'The head office of the concerned bank shall furnish details of such accounts --containing the name , date of arrival in India , passport number , residential permit reference , name of the Foreigner Registration Office @ @ @ @ @ @ @ @ @ @ the bank branch where the account is maintained -- on quarterly basis to the Ministry of Home Affairs ')
GO

INSERT INTO fts_contains_vu_t VALUES (800, 'However , opening of accounts by entities of Bangladesh ownership shall continue to require approval of RBI , it added further ')
GO

INSERT INTO fts_contains_vu_t VALUES (801, 'As per the extant guidelines , opening of Non-Resident Ordinary Rupee ( NRO ) accounts by individuals/entities of Bangladesh/Pakistan nationality/ ownership requires approval of Reserve Bank ')
GO

INSERT INTO fts_contains_vu_t VALUES (802, '<h> Tell the dogs something they have n''t known all along')
GO

INSERT INTO fts_contains_vu_t VALUES (803, 'Here ''s the answer : Of course you do ')
GO

INSERT INTO fts_contains_vu_t VALUES (804, ' All dog owners , in their heart of hearts , are convinced their drooling pet is the canine version of Einstein , only with better grooming ')
GO

INSERT INTO fts_contains_vu_t VALUES (805, 'GUS RUELAS / PURINA / THE ASSOCIATED PRESS ARCHIVES')
GO

INSERT INTO fts_contains_vu_t VALUES (806, 'Cochiti , a six-year-old whippet , competes in a diving dog competition ')
GO

INSERT INTO fts_contains_vu_t VALUES (807, ' A new book argues dogs are smarter than you think ')
GO

INSERT INTO fts_contains_vu_t VALUES (808, 'Stray dogs in Moscow are smart enough to use public transport , a fact accepted by Muscovites who do n''t crowd them on the subway ')
GO

INSERT INTO fts_contains_vu_t VALUES (809, 'The thing is , they ''re right : dogs are geniuses ')
GO

INSERT INTO fts_contains_vu_t VALUES (810, 'In this well-researched , highly readable book , author Brian Hare -- a scientist who is becoming known throughout the world as " that dog guy " -- has laid out a compelling argument for the unique genius of man ''s best friend ')
GO

INSERT INTO fts_contains_vu_t VALUES (811, 'It ''s not that your dog has the skill to paint a masterpiece or compose a @ @ @ @ @ @ @ @ @ @ a special kind of intelligence that gives them more in common with human infants than their wolf ancestors ')
GO

INSERT INTO fts_contains_vu_t VALUES (812, 'Written with his co-researcher and wife , Vanessa Woods , The Genius of Dogs is the first book to provide a complete look at the new world of " dog cognition , " which has been playfully dubbed " dognition ')
GO

INSERT INTO fts_contains_vu_t VALUES (813, 'For hundreds of years , researchers largely overlooked the millions of domesticated dogs that serve as pets or service animals , comfortably working alongside humans ')
GO

INSERT INTO fts_contains_vu_t VALUES (814, 'But in the last 10 years , there has been something of a revolution in the study of canine intelligence , and Hare has been the scientist leading the charge ')
GO

INSERT INTO fts_contains_vu_t VALUES (815, '" We have learned more about how dogs think in the past decade than we have in the previous century , " Hare writes ')
GO

INSERT INTO fts_contains_vu_t VALUES (816, ' " This book is about how cognitive science has come to understand the genius of dogs through experimental games using nothing much more high-tech than toys , cups , balls and anything else lying around the garage ')
GO

INSERT INTO fts_contains_vu_t VALUES (817, 'An evolutionary anthropologist , @ @ @ @ @ @ @ @ @ @ Centre ')
GO

INSERT INTO fts_contains_vu_t VALUES (818, ' Most importantly , he ''s a dog lover ')
GO

INSERT INTO fts_contains_vu_t VALUES (819, ' And , thankfully , he ''s not a blowhard ')
GO

INSERT INTO fts_contains_vu_t VALUES (820, 'In journalism , there ''s a warning : When dealing with experts , beware the expertise ')
GO

INSERT INTO fts_contains_vu_t VALUES (821, ' The concern is when academics write books , they tend to bash readers over the head with scientific jargon in an effort to ensure everyone understands just how clever they are ')
GO

INSERT INTO fts_contains_vu_t VALUES (822, 'Thankfully , Hare , aided by his journalist wife , has crafted a game-changing book that , while faithfully documenting complex research , is clear , jargon-free and relies on a simple narrative style to deliver a truly gripping read ')
GO

INSERT INTO fts_contains_vu_t VALUES (823, 'What does Hare mean when he says dogs are geniuses ? Well , he ''s mostly referring to their ability to spontaneously make inferences , to solve problems by reading human gestures ')
GO

INSERT INTO fts_contains_vu_t VALUES (824, 'Hare recalls his time working at Emory University under a professor named Mike Tomasello , who was trying to figure out what makes us human ')
GO

INSERT INTO fts_contains_vu_t VALUES (825, ' One day , Mike was lamenting that only humans understand " communicative intentions , " which allow @ @ @ @ @ @ @ @ @ @ pointing ')
GO

INSERT INTO fts_contains_vu_t VALUES (826, 'At that moment , the author had a flash of insight ')
GO

INSERT INTO fts_contains_vu_t VALUES (827, ' " I think my dog can do it , " he blurted ')
GO

INSERT INTO fts_contains_vu_t VALUES (828, 'And , through a series of experiments in his parents '' garage with their dog , Oreo , he proved just that ')
GO

INSERT INTO fts_contains_vu_t VALUES (829, ' It turns out that dogs have a unique ability to follow human gestures , such as pointing , to locate a food reward hidden under one of a series of plastic cups ')
GO

INSERT INTO fts_contains_vu_t VALUES (830, 'In fact , dogs are at the top of the class compared with wolves and chimps and other wild animals ')
GO

INSERT INTO fts_contains_vu_t VALUES (831, ' " In short , " Hare writes , " Mike and I concluded that dogs have communicative skills that are amazingly similar to those of infants ')
GO

INSERT INTO fts_contains_vu_t VALUES (832, 'The long-standing belief is that domesticated dogs are less intelligent than wild animals such as wolves and foxes , yet the central point of The Genius of Dogs is that the opposite is true -- human contact has actually increased the genius of the species ')
GO

INSERT INTO fts_contains_vu_t VALUES (833, 'With a nod to Darwin , Hare says @ @ @ @ @ @ @ @ @ @ A friendly wild dog , one that was willing to tolerate proximity to humans , was favoured with a great reward -- a new food supply known as " garbage ')
GO

INSERT INTO fts_contains_vu_t VALUES (834, 'Hare also dispels the myth that scientists have had their senses of humour surgically removed ')
GO

INSERT INTO fts_contains_vu_t VALUES (835, 'In one chapter , he recounts a hilarious , if uncomfortable , evening spent in a Russian sauna , where the other researchers insisted on calling him " Brain " instead of Brian ')
GO

INSERT INTO fts_contains_vu_t VALUES (836, '" I sat naked in a Russian banya , " he writes ')
GO

INSERT INTO fts_contains_vu_t VALUES (837, ' " The air in the sauna was so dry and hot , it scorched my windpipe all the way down to my lungs ')
GO

INSERT INTO fts_contains_vu_t VALUES (838, ' The other eight Russian men , also naked , were leaning against the cedar walls , their eyes closed in ecstasy , as though slowly roasting yourself alive was the most relaxing thing in the world ')
GO

INSERT INTO fts_contains_vu_t VALUES (839, 'There ''s a lot more vodka and jumping through holes in the ice involved , but you can find that out for yourself ')
GO

INSERT INTO fts_contains_vu_t VALUES (840, ' We also are n''t going to @ @ @ @ @ @ @ @ @ @ the smartest ')
GO

INSERT INTO fts_contains_vu_t VALUES (841, 'You ''re going to have to go out and buy the book ')
GO

INSERT INTO fts_contains_vu_t VALUES (842, ' In fact , we suggest you pick up two -- get one for your dog , because , after all , he ''s a genius ')
GO

INSERT INTO fts_contains_vu_t VALUES (843, 'Book review')
GO

INSERT INTO fts_contains_vu_t VALUES (844, 'History')
GO

INSERT INTO fts_contains_vu_t VALUES (845, 'Updated on Saturday , February 16 , 2013 at 1:43 PM CST : adds fact box')
GO

INSERT INTO fts_contains_vu_t VALUES (846, 'You can comment on most stories on winnipegfreepress')
GO

INSERT INTO fts_contains_vu_t VALUES (847, ' You can also agree or disagree with other comments ')
GO

INSERT INTO fts_contains_vu_t VALUES (848, ' All you need to do is be a Winnipeg Free Press print or e-edition subscriber to join the conversation and give your feedback ')
GO

INSERT INTO fts_contains_vu_t VALUES (849, '<p> A novel experiment that gives rats the ability to " feel " infrared light by hijacking their sense of touch may require scientists to re-evaluate their ideas about how the brain works , says the lead researcher behind the study ')
GO

INSERT INTO fts_contains_vu_t VALUES (850, 'Six rats were implanted with electrodes that connect their brains to infrared sensors they wore on the tops of their heads ')
GO

INSERT INTO fts_contains_vu_t VALUES (851, ' The electrodes were inserted into each animal ''s somatosensory cortex -- the part of a rat ''s brain that is responsible for sensing touch , particularly through the whiskers ')
GO

INSERT INTO fts_contains_vu_t VALUES (852, 'Multimedia')
GO

INSERT INTO fts_contains_vu_t VALUES (853, 'Hacking the Brain')
GO

INSERT INTO fts_contains_vu_t VALUES (854, 'When the wired rats were placed in a situation where infrared lights were turned on and off around them , they first responded as though they were feeling an invisible touch to their whiskers ')
GO

INSERT INTO fts_contains_vu_t VALUES (855, ' Within a few days , however , the rats '' responses changed and they were able to identify and move toward sources of infrared light as though " seeing " them in the distance ')
GO

INSERT INTO fts_contains_vu_t VALUES (856, '" They basically started behaving like they ''re projecting the sensation of touch into the @ @ @ @ @ @ @ @ @ @ of neurobiology and bioengineering at Duke University in Durham , North Carolina , who led the experiment ')
GO

INSERT INTO fts_contains_vu_t VALUES (857, 'What is especially intriguing is that Dr')
GO

INSERT INTO fts_contains_vu_t VALUES (858, ' Nicolelis and his colleagues made no special effort to connect the infrared sensors to specific neurons apart from placing then in the general brain region associated with touch ')
GO

INSERT INTO fts_contains_vu_t VALUES (859, '" We did n''t have to go fishing for the right cells , " says Dr')
GO

INSERT INTO fts_contains_vu_t VALUES (860, ' Nicolelis ')
GO

INSERT INTO fts_contains_vu_t VALUES (861, 'The results suggest that adult brains are for more plastic than expected and , aided by so-called neuro-prosthetic devices , can quickly develop new sensory modalities that operate on top of the conventional five senses ')
GO

INSERT INTO fts_contains_vu_t VALUES (862, ' Nicolelis says the work could lead to ways of helping human patients acquire a different kind of sight even when the visual cortex is damaged ')
GO

INSERT INTO fts_contains_vu_t VALUES (863, ' Currently , damage to the brain ''s visual processing centre is considered an insurmountable barrier to regaining a sense of sight ')
GO

INSERT INTO fts_contains_vu_t VALUES (864, 'In the future , Dr')
GO

INSERT INTO fts_contains_vu_t VALUES (865, ' Nicolelis adds , people who suffer no impairments at all may opt to add to their sensory capabilities with implants that allow them to @ @ @ @ @ @ @ @ @ @ " I tell my students that Superman must have a neuro-prosthesis for X-ray vision , " says Dr')
GO

INSERT INTO fts_contains_vu_t VALUES (866, ' Nicolelis ')
GO

INSERT INTO fts_contains_vu_t VALUES (867, 'The study , published in the journal Nature Communications , is one of several illustrating the rapid advancements under way in brain-machine interfaces ')
GO

INSERT INTO fts_contains_vu_t VALUES (868, ' The field is the focus of a session on Sunday at the annual meeting of the American Association for the Advancement of Science in Boston ')
GO

INSERT INTO fts_contains_vu_t VALUES (869, 'The work has also attracted the attention of bioethicists exploring how technologies that enhance the brain may one day change our concept of what it means to be human ')
GO

INSERT INTO fts_contains_vu_t VALUES (870, ' Despite the futuristic nature of the technology , it not too soon to discuss its implications , says Martha Farah , director of the Center for Neuroscience and Society at the University of Pennsylvania in Philadelphia ')
GO

INSERT INTO fts_contains_vu_t VALUES (871, '" Part of the point in having discussions at this stage , in anticipation of these technologies being available , is that we can perhaps decide how would we like our society to manage and guide their use , " says Dr')
GO

INSERT INTO fts_contains_vu_t VALUES (872, ' Farah ')
GO

INSERT INTO fts_contains_vu_t VALUES (873, 'Restrictions')
GO

INSERT INTO fts_contains_vu_t VALUES (874, 'All rights reserved ')
GO

INSERT INTO fts_contains_vu_t VALUES (875, ' @ @ @ @ @ @ @ @ @ @ framing or similar means , is prohibited without the prior written consent of Thomson Reuters ')
GO

INSERT INTO fts_contains_vu_t VALUES (876, ' Thomson Reuters is not liable for any errors or delays in Thomson Reuters content , or for any actions taken in reliance on such content ')
GO

INSERT INTO fts_contains_vu_t VALUES (877, ' '' Thomson Reuters '' and the Thomson Reuters logo are trademarks of Thomson Reuters and its affiliated companies ')
GO

INSERT INTO fts_contains_vu_t VALUES (878, '<h> video')
GO

INSERT INTO fts_contains_vu_t VALUES (879, 'video')
GO

INSERT INTO fts_contains_vu_t VALUES (880, 'If you said ( f ) , you ''re right ')
GO

INSERT INTO fts_contains_vu_t VALUES (881, ' In the perfumed salons of Rosedale , Toronto ''s gilded midtown neighbourhood , I have heard people whisper about another that " she really should do something about those lines " as though a shot of Botox is a matter of simple maintenance , like having your leaves blown off your lawn ')
GO

INSERT INTO fts_contains_vu_t VALUES (882, ' To not do it is seen as a failure of community manners ')
GO

INSERT INTO fts_contains_vu_t VALUES (883, 'I have also observed women who submit to the facial needle out of a sense of obligation to their physical beauty ')
GO

INSERT INTO fts_contains_vu_t VALUES (884, ' They may never say this , of course , but the sentiment is there ')
GO

INSERT INTO fts_contains_vu_t VALUES (885, ' That their effort to preserve it often goes awry and they end up looking like plastic of themselves ( I ''m looking at you , Nicole Kidman ) is not the point ')
GO

INSERT INTO fts_contains_vu_t VALUES (886, ' It ''s often a function of identity : They are their beauty ')
GO

INSERT INTO fts_contains_vu_t VALUES (887, ' Not to try to sustain it is akin to not fully using the brain you were born with ')
GO

INSERT INTO fts_contains_vu_t VALUES (888, 'And @ @ @ @ @ @ @ @ @ @ look like a grouch when they do n''t feel they are ')
GO

INSERT INTO fts_contains_vu_t VALUES (889, ' In her book Lots of Candles , Plenty of Cake , Anna Quindlen , the 60-year-old novelist and journalist who famously chronicled thirtysomething life back in the 1980s , wrote that she started using Botox for her frown lines in her mid-50s because she did n''t want to look cross when she was n''t ')
GO

INSERT INTO fts_contains_vu_t VALUES (890, ' " And it ''s addictive , " she told me with a laugh when I interviewed her about the book ')
GO

INSERT INTO fts_contains_vu_t VALUES (891, ' This is where the Botox-as-sex metaphor comes in ')
GO

INSERT INTO fts_contains_vu_t VALUES (892, ' Once you get a taste of it , it ''s hard not to want a repeat , er , injection ')
GO

INSERT INTO fts_contains_vu_t VALUES (893, 'It is the treatment of depression through Botox , though , that is as new as a baby ''s skin ')
GO

INSERT INTO fts_contains_vu_t VALUES (894, ' In The Face of Emotion : How Botox Affects Our Moodsand Relationships , released two weeks ago , Eric Finzi , a dermatological surgeon , writes of the link between facial expressions and emotions ')
GO

INSERT INTO fts_contains_vu_t VALUES (895, ' His theories and anecdotal evidence have recently been corroborated by thorough medical studies ')
GO

INSERT INTO fts_contains_vu_t VALUES (896, ' ( Incidentally @ @ @ @ @ @ @ @ @ @ d ) above , which he heard from one of his patients ')
GO

INSERT INTO fts_contains_vu_t VALUES (897, 'It ''s not simply that a Botox injection to the face can make you feel happier because you look better ')
GO

INSERT INTO fts_contains_vu_t VALUES (898, 'That ''s the assumption many make , Finzi acknowledges in an interview from Chevy Chase , Md')
GO

INSERT INTO fts_contains_vu_t VALUES (899, ' , where he lives and works ')
GO

INSERT INTO fts_contains_vu_t VALUES (900, ' And he does n''t dispute that looking good makes you feel good -- that ''s his business after all ')
GO

INSERT INTO fts_contains_vu_t VALUES (901, 'Rather , Finzi ''s work centres around the new and controversial idea that our facial expressions not only reflect our emotions , but also cause them ')
GO

INSERT INTO fts_contains_vu_t VALUES (902, ' It ''s a " facial feedback theory of emotion " that he describes as a continuous looping of signals or pathways between muscles and the brain ')
GO

INSERT INTO fts_contains_vu_t VALUES (903, ' Basically , the more you frown , the more the brain experiences negative messaging ')
GO

INSERT INTO fts_contains_vu_t VALUES (904, ' So when Botox inhibits the frown muscle , " that electrical circuit is clamped off , " Finzi explains over the phone ')
GO

INSERT INTO fts_contains_vu_t VALUES (905, 'In 2003 , he started a clinical trial to test his hypothesis that Botox inhibition of @ @ @ @ @ @ @ @ @ @ scientific theories from the 19th century , including Charles Darwin ''s The Expression of the Emotions in Manand Animals , in which the celebrated scientist wrote : " The free expression by outward signs of an emotion intensifies it ')
GO

INSERT INTO fts_contains_vu_t VALUES (906, ' On the other hand , the repression , as far as this is possible , of all outward signs softens our emotions ')
GO

INSERT INTO fts_contains_vu_t VALUES (907, 'Finally , Finzi realized that he had a way to test ancient hypotheses with a modern tool : Botox ')
GO

INSERT INTO fts_contains_vu_t VALUES (908, 'His small studies also piqued the interest of Axel Wollmer , a psychiatrist at the University of Basel in Switzerland ')
GO

INSERT INTO fts_contains_vu_t VALUES (909, ' Last year , results of his randomized controlled study on the effects of Botox on depression were published in the Journal of Psychiatric Research , showing significant statistical results ')
GO

INSERT INTO fts_contains_vu_t VALUES (910, ' The study investigated whether patients who suffered from clinical depression and had not responded to antidepressant medications could be helped with Botox injections in their frown lines ')
GO

INSERT INTO fts_contains_vu_t VALUES (911, 'Participants in the treatment group were given a single dose of Botox ( five injections ) between and just above their eyebrows ')
GO

INSERT INTO fts_contains_vu_t VALUES (912, ' An equal-sized @ @ @ @ @ @ @ @ @ @ Botox , symptoms of depression decreased 47 per cent after six weeks and lasted through the 16-week study period ')
GO

INSERT INTO fts_contains_vu_t VALUES (913, ' In the placebo group , there was a nine per cent reduction in symptoms ')
GO

INSERT INTO fts_contains_vu_t VALUES (914, ' Wollmer concluded that Botox " interrupts feedback from the facial musculature to the brain , which may be involved in the development and maintenance of negative emotion ')
GO

INSERT INTO fts_contains_vu_t VALUES (915, 'What has hindered investigations into Botox and depression is the stigma it carries as merely a tool for the vain even though its uses for medical conditions such as cerebral palsy , Parkinson ''s disease and migraines are well known , Finzi says ')
GO

INSERT INTO fts_contains_vu_t VALUES (916, '" Do n''t blame the molecule ! " he implores with a laugh ')
GO

INSERT INTO fts_contains_vu_t VALUES (917, ' " Do n''t attach whatever feelings you have about cosmetic procedures to its potential usefulness for other things ')
GO

INSERT INTO fts_contains_vu_t VALUES (918, ' I would predict that , by the end of 2013 , there will be not only one but three randomized , controlled , double-blind tests that will have been completed ')
GO

INSERT INTO fts_contains_vu_t VALUES (919, 'And when all three are published , that will be very powerful stuff ')
GO

INSERT INTO fts_contains_vu_t VALUES (920, '@ @ @ @ @ @ @ @ @ @ pharmaceutical companies ')
GO

INSERT INTO fts_contains_vu_t VALUES (921, 'Depression , of course , is a serious problem ')
GO

INSERT INTO fts_contains_vu_t VALUES (922, ' And anything that can help alleviate it is significant ')
GO

INSERT INTO fts_contains_vu_t VALUES (923, ' But I ca n''t help but think that this news would provide the perfect excuse for indulging in Botox from here on in ')
GO

INSERT INTO fts_contains_vu_t VALUES (924, ' " It ''s not for my vanity , darling , " you could say at swishy soirees as your friends notice your newly unfurrowed brow ')
GO

INSERT INTO fts_contains_vu_t VALUES (925, '<p> Women and visible minorities are underrepresented in senior leadership positions across Montreal , according to a report published by Ryerson University ''s Diversity Institute and the Desautels Faculty of Management at McGill ')
GO

INSERT INTO fts_contains_vu_t VALUES (926, 'The report -- part of DiversityLeads , a five-year , $2')
GO

INSERT INTO fts_contains_vu_t VALUES (927, '5-million project funded by the federal Social Sciences and Humanities Research Council ( SSHRC ) -- aims to " benchmark and assess the progress of diversity in leadership " to develop specific solutions to advance diversity across Canada ')
GO

INSERT INTO fts_contains_vu_t VALUES (928, ' It examined six sectors : elected , public , private , education , voluntary , and appointments to Agencies , Boards and Commissions ')
GO

INSERT INTO fts_contains_vu_t VALUES (929, 'The study found that women accounted for 31')
GO

INSERT INTO fts_contains_vu_t VALUES (930, '2 per cent of senior leadership positions , despite comprising 51')
GO

INSERT INTO fts_contains_vu_t VALUES (931, '7 per cent of the population of surveyed areas in greater Montreal ')
GO

INSERT INTO fts_contains_vu_t VALUES (932, 'The figure for visible minorities was even lower , standing at only 5')
GO

INSERT INTO fts_contains_vu_t VALUES (933, '9 per cent , despite visible minorities comprising 22')
GO

INSERT INTO fts_contains_vu_t VALUES (934, '5 per cent of the population ')
GO

INSERT INTO fts_contains_vu_t VALUES (935, ' The problem compounds itself for women that are visible minorities , who represent 11')
GO

INSERT INTO fts_contains_vu_t VALUES (936, '5 per cent of the population , but @ @ @ @ @ @ @ @ @ @ The corporate sector was found to be the least diverse , with women at 15')
GO

INSERT INTO fts_contains_vu_t VALUES (937, '1 per cent and minorities at 2')
GO

INSERT INTO fts_contains_vu_t VALUES (938, '6 per cent ')
GO

INSERT INTO fts_contains_vu_t VALUES (939, ' By comparison , the government and education sectors both had over 40 per cent women , with 9')
GO

INSERT INTO fts_contains_vu_t VALUES (940, '6 and 6')
GO

INSERT INTO fts_contains_vu_t VALUES (941, '4 per cent visible minorities , respectively ')
GO

INSERT INTO fts_contains_vu_t VALUES (942, 'Wendy Cukier , founder and director of the Diversity Institute at Ryerson University and a lead researcher on the project , highlighted the significance of the sector-based approach to this research in an email to The Daily ')
GO

INSERT INTO fts_contains_vu_t VALUES (943, 'In a phone interview with The Daily , Suzanne Gagnon , another researcher on the project and a professor of organizational behaviour at Desautels , warned that sector averages should not necessarily be taken at face value , and that there is often a wide range of representation within sectors ')
GO

INSERT INTO fts_contains_vu_t VALUES (944, ' She suggested that certain organizations could act as models for others within the same sector ')
GO

INSERT INTO fts_contains_vu_t VALUES (945, 'She explained that phase two of the research would include a cross-sectoral survey and case studies to discover specific reasons for , and solutions to , the problem ')
GO

INSERT INTO fts_contains_vu_t VALUES (946, 'Gagnon emphasized @ @ @ @ @ @ @ @ @ @ the top of an organization has been linked to a company or organization ''s ability to retain top talent , and also as a separate issue -- although they are linked to an extent -- to innovate , to make innovative and creative decisions drawing on multiple perspectives ')
GO

INSERT INTO fts_contains_vu_t VALUES (947, 'She also explained that , " it matters for young people and for their aspirations and for social inclusion more generally to have leaders who broadly represent the population ')
GO

INSERT INTO fts_contains_vu_t VALUES (948, 'Elizabeth Groeneveld , a faculty lecturer and chair of the Women ''s Studies program at McGill , explained that underrepresentation in leadership in Montreal is likely linked to broader systemic racism and sexism ')
GO

INSERT INTO fts_contains_vu_t VALUES (949, '" There can be impediments in terms of access to education and the kind of mentoring that is often given to men or people who are racialized as white that is not always extended in the same way to women and visible minorities , " said Groeneveld ')
GO

INSERT INTO fts_contains_vu_t VALUES (950, 'Gagnon , in reference to both the corporate sector and as a general trend , described how organizations are " self-reproducing entities " that @ @ @ @ @ @ @ @ @ @ a systemic obstacle to introducing women and visible minorities ')
GO

INSERT INTO fts_contains_vu_t VALUES (951, 'Groeneveld echoed this idea : " The language of being '' the right fit '' for a company can sometimes become code for people who look like us , think like us , and talk like us ')
GO

INSERT INTO fts_contains_vu_t VALUES (952, 'Cukier noted that several other projects are in progress as part of DiversityLeads , including studies on the representation of Aboriginal people , persons with disabilities , and members of LGBT communities , as well as analysis on the impact of representations of leadership in media ')
GO

INSERT INTO fts_contains_vu_t VALUES (953, ' Gagnon mentioned that similar studies were also conducted in other major Canadian cities , including Vancouver and Toronto ')
GO

INSERT INTO fts_contains_vu_t VALUES (954, '<h> Private prisons '' are run better '' than those in public sector')
GO

INSERT INTO fts_contains_vu_t VALUES (955, 'Private firms are better at running prisons than the public sector and all jails should be subject to open competition , an independent think-tank said today ')
GO

INSERT INTO fts_contains_vu_t VALUES (956, 'Better staff-prisoner relationships , boosted by the use of first names and mentoring schemes , help rid private jails of hostilitiesPhoto : PA')
GO

INSERT INTO fts_contains_vu_t VALUES (957, '2:45AM GMT 21 Feb 2013')
GO

INSERT INTO fts_contains_vu_t VALUES (958, 'The Government would be wrong to limit the role of private companies within prisons to small contracts such as maintenance and catering , the right-leaning group Reform said ')
GO

INSERT INTO fts_contains_vu_t VALUES (959, 'Some 10 out of 12 privately managed prisons have lower reoffending rates among offenders serving 12 months or more than comparable public sector prisons , Reform found ')
GO

INSERT INTO fts_contains_vu_t VALUES (960, 'Meanwhile , the group also called for the end to national pay bargaining for prison officers with pay and conditions to be set locally by governors ')
GO

INSERT INTO fts_contains_vu_t VALUES (961, 'The coalition Government denied there had been a '' '' U-turn '' '' on the use of prison competition , while campaigners for prison reform said it was almost @ @ @ @ @ @ @ @ @ @ Tanner , who penned the report The Case for Private Prisons , said : '' '' Twenty years of private prisons have created an effective market which is ready to grow ')
GO

INSERT INTO fts_contains_vu_t VALUES (962, ' Evidence shows that a greater role for the private sector will advance the '' rehabilitation revolution '' which ministers want to deliver ')
GO

INSERT INTO fts_contains_vu_t VALUES (963, 'Private firms have been managing prisons since 1992 , but in November last year Justice Secretary Chris Grayling signalled a move away from wholesale privatisation as he decided four prisons , including G4S-run HMP Wolds , should be run by the public sector ')
GO

INSERT INTO fts_contains_vu_t VALUES (964, 'Two contracts to run five prisons -- Acklington and Castington , which have since formed Northumberland prison , and three in South Yorkshire -- will proceed to the next stage of the competition with an announcement expected next spring ')
GO

INSERT INTO fts_contains_vu_t VALUES (965, 'Mr Grayling said private firms will be brought in to all public prisons to run maintenance , resettlement and catering to save up to ? 450 million over six years ')
GO

INSERT INTO fts_contains_vu_t VALUES (966, 'Policy groups , including Reform , said the decision amounted to the end of competition @ @ @ @ @ @ @ @ @ @ although Mr Grayling insisted it did not rule out further prison-by-prison competitions in the future ')
GO

INSERT INTO fts_contains_vu_t VALUES (967, 'Looking at Ministry of Justice data , Reform said this decision was not supported by analysis of prison effectiveness ')
GO

INSERT INTO fts_contains_vu_t VALUES (968, 'Some seven out of 10 privately managed prisons have lower reoffending rates among offenders serving fewer than 12 months , compared to comparable public sector prisons ')
GO

INSERT INTO fts_contains_vu_t VALUES (969, 'Furthermore , Reform said private prisons outperform their public counterparts in four of the performance measures used by the MoJ ')
GO

INSERT INTO fts_contains_vu_t VALUES (970, 'A total of 12 out of 12 private jails performed better than the public sector at '' '' resource management and operational effectiveness '' '' , while seven out of 12 were better at '' '' reducing re-offending '' '' ')
GO

INSERT INTO fts_contains_vu_t VALUES (971, 'However , seven out of 12 public prisons performed better than private jails at '' '' public protection '' '' ')
GO

INSERT INTO fts_contains_vu_t VALUES (972, 'In the report , Mr Tanner argues : '' '' Private contractors outperform comparable public sector prisons on both cost and quality , delivering better value for money for the taxpayer ')
GO

INSERT INTO fts_contains_vu_t VALUES (973, ''' '' In addition , the @ @ @ @ @ @ @ @ @ @ similar public sector prisons for both long and short-term prisoners , a key Government objective ')
GO

INSERT INTO fts_contains_vu_t VALUES (974, 'As a result , Reform recommends that all prisons should be subject to competition including the private sector ')
GO

INSERT INTO fts_contains_vu_t VALUES (975, 'It also calls for local pay decision-making to be introduced in prisons , with governors taking on responsibility for deciding staffing arrangements , pay and conditions and performance-related pay ')
GO

INSERT INTO fts_contains_vu_t VALUES (976, 'This would spell the end of national pay bargaining for prison officers , a move that would spark fury among unions ')
GO

INSERT INTO fts_contains_vu_t VALUES (977, 'Mr Tanner said : '' '' Market-facing pay and adaptable staffing arrangements have not only reduced cost considerably but also improved staff-prisoner relationships and internal cultures within prisons ')
GO

INSERT INTO fts_contains_vu_t VALUES (978, 'Justice Minister Jeremy Wright said : '' '' Reoffending rates across the entire prison estate are too high and we are pressing ahead with major reforms to tackle this unacceptable problem ')
GO

INSERT INTO fts_contains_vu_t VALUES (979, ''' '' And let ''s be clear -- there has been no U-turn on the use of prison competition ')
GO

INSERT INTO fts_contains_vu_t VALUES (980, ''' '' The cost of running our prisons is too high and @ @ @ @ @ @ @ @ @ @ new approach for reducing costs and improving services aimed at reducing reoffending at a faster rate involving the private sector ')
GO

INSERT INTO fts_contains_vu_t VALUES (981, 'Mr Wright added : '' '' This simplistic analysis does not tell the whole story -- a wide range of factors contribute to reoffending including previous criminal behaviour , drug and alcohol dependency and the support offenders receive on release from prison ')
GO

INSERT INTO fts_contains_vu_t VALUES (982, ' This is why we are committed to introducing significant reforms that will bring down our stubbornly high reoffending rates ')
GO

INSERT INTO fts_contains_vu_t VALUES (983, 'She said : '' '' It is almost impossible to compare the performance and reoffending rates of one establishment with another , partly because prisons hold different categories of offenders and also because prisoners often serve their sentences in a number of different jails ')
GO

INSERT INTO fts_contains_vu_t VALUES (984, ' '' '' \n')
GO

INSERT INTO fts_contains_vu_t VALUES (985, '<p> It ''s thought that the chemical resveratrol , found in red grapes and red wine , is the reason why ')
GO

INSERT INTO fts_contains_vu_t VALUES (986, 'Resveratrol , a chemical found in red grapes and red wine , may protect against hearing loss')
GO

INSERT INTO fts_contains_vu_t VALUES (987, 'This is the same compound that has been linked with other positive health benefits such as preventing cancer and heart disease ')
GO

INSERT INTO fts_contains_vu_t VALUES (988, 'In a study conducted at the Henry Ford Hospital in Detroit , healthy rats were less likely to suffer noise-induced hearing loss when given resveratrol before being exposed to loud noise for a long period of time ')
GO

INSERT INTO fts_contains_vu_t VALUES (989, 'RELATED ARTICLES')
GO

INSERT INTO fts_contains_vu_t VALUES (990, 'Share this article')
GO

INSERT INTO fts_contains_vu_t VALUES (991, 'Share')
GO

INSERT INTO fts_contains_vu_t VALUES (992, 'Study leader Dr Michael Seidman said : '' Our latest study focuses on resveratrol and its effect on the body ''s response to injury - something that is believed to be the cause of many health problems including Alzheimer ''s disease , cancer , ageing and hearing loss ')
GO

INSERT INTO fts_contains_vu_t VALUES (993, 'Resveratrol appeared to reduce the damage to hearing from loud noises')
GO

INSERT INTO fts_contains_vu_t VALUES (994, ''' Resveratrol is a very powerful chemical that seems to protect against the body @ @ @ @ @ @ @ @ @ @ cognition brain function and hearing loss ')
GO

INSERT INTO fts_contains_vu_t VALUES (995, 'Hearing loss affects half of people over the age of 60 , but many begin to suffer problems in their 40s or 50s ')
GO

INSERT INTO fts_contains_vu_t VALUES (996, 'It usually sets in with the death of tiny '' hair '' cells in the inner ear as a result of ageing ')
GO

INSERT INTO fts_contains_vu_t VALUES (997, 'The study found that resveratrol reduced noise-induced hearing loss in rats exposed to potentially deafening sounds ')
GO

INSERT INTO fts_contains_vu_t VALUES (998, 'Dr Seidman said : '' We ''ve shown that by giving animals resveratrol , we can reduce the amount of hearing and cognitive decline ')
GO

INSERT INTO fts_contains_vu_t VALUES (999, 'The study is published in the journal Otolaryngology-Head and Neck Surgery ')
GO

INSERT INTO fts_contains_vu_t VALUES (1000, 'Last month , scientists from the Hebrew University of Jerusalem reported that washing down red meat with a glass of red can actually prevent the build-up of cholesterol in the body ')
GO

-- disable CONTAINS
SELECT set_config('babelfishpg_tsql.escape_hatch_fulltext', 'strict', 'false')
GO