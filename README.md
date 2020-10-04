# NYTBooks

## Requirement 

You will need an API key from [NY Times API](https://developer.nytimes.com/docs/books-product/1/overview) portal.

Once you have your api key nytb will use the environment variable `NYT_BOOK_API` during runtime to necessary make API calls.

## Available Commands

### list

#### List available categories

`nytb list --list` 
    
    1    Combined Print & E-Book Fiction
    2    Combined Print & E-Book Nonfiction
    3    Hardcover Fiction
    4    Hardcover Nonfiction
    ...
    19    Young Adult Paperback - Monthly

#### List best sellers for a given category

`nytb list -l 4`

    +---------------------------------------------------------------------------------------------------------------------------------+
    | Hardcover Nonfiction                                                                                                            |
    +---------------------------------------------------------------------------------------------------------------------------------+
    | Title                | Author               | ISBN 13       | Amazon                                                            |
    +----------------------+----------------------+---------------+-------------------------------------------------------------------+
    | Rage                 | Bob Woodward         | 9781982131739 | https://www.amazon.com/dp/198213173X?tag=NYTBSREV-20&tag=NYTBS-20 |
    | Killing Crazy Horse  | Bill O'Reilly and Ma | 9781627797047 | https://www.amazon.com/dp/1627797041?tag=NYTBSREV-20&tag=NYTBS-20 |
    | Blackout             | Candace Owens        | 9781982133276 | https://www.amazon.com/dp/1982133279?tag=NYTBSREV-20&tag=NYTBS-20 |
    | Caste                | Isabel Wilkerson     | 9780593230251 | https://www.amazon.com/dp/0593230256?tag=NYTBSREV-20&tag=NYTBS-20 |
    ...
    | Everything Beautiful | Jenna Bush Hager     | 9780062960627 | https://www.amazon.com/dp/0062960628?tag=NYTBSREV-20&tag=NYTBS-20 |
    | Too Much And Never E | Mary L Trump         | 9781982141462 | https://www.amazon.com/dp/1982141468?tag=NYTBSREV-20&tag=NYTBS-20 |
    +----------------------+----------------------+---------------+-------------------------------------------------------------------+

### review

#### Looks up available reviews for a given book

`nytb review 9780525509288`

    How to Be an Antiracist by Ibram X. Kendi
    In “How to Be an Antiracist,” the scholar Ibram X. Kendi scrutinizes himself and the rest of us for lessons on how to eradicate the scourge of racism.
    Reviewed by: Jeffrey C. Stewart
    https://www.nytimes.com/2019/08/20/books/review/how-to-be-an-antiracist-ibram-x-kendi.html

### overview

#### Get top 5 for all available categories

`nytb overview`

    Combined Print & E-Book Fiction
    1 The Book Of Two Ways | by: Jodi Picoult
    Description: After surviving a plane crash, a death doula travels to Egypt to reconnect with an old flame who is an archaeologist.
    Purchase:
        Amazon:https://www.amazon.com/dp/198481835X?tag=NYTBSREV-20?tag=NYTBS-20
        Bookshop:https://bookshop.org/a/3546/9781984818355
        Indiebound:https://www.indiebound.org/book/9781984818355?aff=NYT
    
    ...
    
    Children’s Series
    1 Dog Man | by: Dav Pilkey
    Description: A dog’s head is combined with a policeman’s body to create this hybrid supercop hound.
    Purchase:
        Amazon:https://www.amazon.com/Dog-Man-Kitties-Creator-Underpants/dp/0545935210?tag=NYTBS-20
        Bookshop:https://bookshop.org/a/3546/9781338535624
        Indiebound:https://www.indiebound.org/book/9781338535624?aff=NYT
    ...

#### Get top 5 for a given category

`nytb overview -l 4`

    Hardcover Nonfiction
    1 Rage | by: Bob Woodward
    Description: Based on 17 on-the-record interviews with President Trump and other reporting, the Pulitzer Prize-winning journalist details the president’s perspective on multiple crises.
    Purchase:
        Amazon:https://www.amazon.com/dp/198213173X?tag=NYTBSREV-20?tag=NYTBS-20
        Bookshop:https://bookshop.org/a/3546/9781982131739
        Indiebound:https://www.indiebound.org/book/9781982131739?aff=NYT
    
