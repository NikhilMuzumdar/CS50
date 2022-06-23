-- Keep a log of any SQL queries you execute as you solve the mystery.
-- (Command 1: check available tables)
.schema
-- (Command 2: Check crime scheme reports on the theft date)
select
  description
from
  crime_scene_reports
where
  (
    year = 2021
    and month = 7
    and day = 28
    and street = 'Humphrey Street'
  );
-- INFO from crime_scene_reports:
-- Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
-- Interviews were conducted today with three witnesses who were present at the time.
-- each of their interview transcripts mentions the bakery. |
-- Littering took place at 16:36. No known witnesses.
-- Inference:
-- Time of Theft: 10:15 am
-- Three Witness
-- (Command 3: Check interview transcripts)
select
  name,
  transcript
from
  interviews
where
  (
    year = 2021
    and month = 7
    and day = 28
  )
  and transcript LIKE "%bakery%";
-- INFO
-- (a) | Ruth |
-- Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away.
-- If you have security footage from the bakery parking lot, you might want to look for cars that left the parking
-- lot in that time frame.
-- (b) | Eugene |
-- I don't know the thief's name, but it was someone I recognized.
-- Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street
-- and saw the thief there withdrawing some money.
-- (c) | Raymond |
-- As the thief was leaving the bakery, they called someone who talked to them for less than a minute.
-- In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.
-- The thief then asked the person on the other end of the phone to purchase the flight ticket.
-- Action
-- (1) Check for cars that left the parking lot within 10 min of 10:15 AM (Ruth's lead)
-- (2) Check the withdrawal data of ATM on the morning of 2021-7-28 (Eugene's lead)
-- (3) Check call logs and flight tickets for next day and see if common name pops up
-- (Command 4: Check parking details from bakery security logs)
select
  license_plate
from
  bakery_security_logs
where
  (
    year = 2021
    and month = 7
    and day = 28
    and hour = 10
    and activity = 'exit'
    and minute <= 25
  );
-- SUSPECT NUMBERS: 5P2BI95, 94KL13X, 6P58WS2, 4328GD8, G412CB7, L93JTIZ, 322W7JE, 0NTHK55
-- (Command 5: From People Data check number plate owners)
select
  *
from
  people
where
  license_plate in (
    select
      license_plate
    from
      bakery_security_logs
    where
      (
        year = 2021
        and month = 7
        and day = 28
        and hour = 10
        and activity = 'exit'
        and minute <= 25
      )
  );
-- Datapoint 1: We now have below data as per info provided by Ruth:
-- +--------+---------+----------------+-----------------+---------------+
-- |   id   |  name   |  phone_number  | passport_number | license_plate |
-- +--------+---------+----------------+-----------------+---------------+
-- | 221103 | Vanessa | (725) 555-4692 | 2963008352      | 5P2BI95       |
-- | 243696 | Barry   | (301) 555-4174 | 7526138472      | 6P58WS2       |
-- | 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       |
-- | 398010 | Sofia   | (130) 555-0289 | 1695452385      | G412CB7       |
-- | 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       |
-- | 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
-- | 560886 | Kelsey  | (499) 555-9472 | 8294398571      | 0NTHK55       |
-- | 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
-- +--------+---------+----------------+-----------------+---------------+
-- (Command 6: Get bank account number from the ATM withdrawal transactions on the day of theft at Leggett Street)
select
  account_number
from
  atm_transactions
where
  (
    year = 2021
    and month = 7
    and day = 28
    and atm_location = 'Leggett Street'
    and transaction_type = 'withdraw'
  );
-- (Command 7: Get person_id from bank details)
select
  person_id
from
  bank_accounts
where
  account_number in (
    select
      account_number
    from
      atm_transactions
    where
      (
        year = 2021
        and month = 7
        and day = 28
        and atm_location = 'Leggett Street'
        and transaction_type = 'withdraw'
      )
  );
-- (Command 8: Get person name from people details)
select
  *
from
  people
where
  id in (
    select
      person_id
    from
      bank_accounts
    where
      account_number in (
        select
          account_number
        from
          atm_transactions
        where
          (
            year = 2021
            and month = 7
            and day = 28
            and atm_location = 'Leggett Street'
            and transaction_type = 'withdraw'
          )
      )
  );
-- Datapoint 2: We now have below data per info provided by Eugene:
-- +--------+---------+----------------+-----------------+---------------+
-- |   id   |  name   |  phone_number  | passport_number | license_plate |
-- +--------+---------+----------------+-----------------+---------------+
-- | 395717 | Kenny   | (826) 555-1652 | 9878712108      | 30G67EN       |
-- | 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       |
-- | 438727 | Benista | (338) 555-6650 | 9586786673      | 8X428L0       |
-- | 449774 | Taylor  | (286) 555-6063 | 1988161715      | 1106N58       |
-- | 458378 | Brooke  | (122) 555-4581 | 4408372428      | QX4YZN3       |
-- | 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       |
-- | 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
-- | 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
-- +--------+---------+----------------+-----------------+---------------+
-- Check the calls that were made which lasted less than a minute and get people data by tracing phone numbers
select
  caller
from
  phone_calls
where
  (
    year = 2021
    and month = 7
    and day = 28
    and duration <= 60
  );
select
  *
from
  people
where
  phone_number in (
    select
      caller
    from
      phone_calls
    where
      (
        year = 2021
        and month = 7
        and day = 28
        and duration <= 60
      )
  );
-- Datapoint 3: We now have below data per info provided by Raymond:
-- +--------+---------+----------------+-----------------+---------------+
-- |   id   |  name   |  phone_number  | passport_number | license_plate |
-- +--------+---------+----------------+-----------------+---------------+
-- | 395717 | Kenny   | (826) 555-1652 | 9878712108      | 30G67EN       |
-- | 398010 | Sofia   | (130) 555-0289 | 1695452385      | G412CB7       |
-- | 438727 | Benista | (338) 555-6650 | 9586786673      | 8X428L0       |
-- | 449774 | Taylor  | (286) 555-6063 | 1988161715      | 1106N58       |
-- | 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
-- | 560886 | Kelsey  | (499) 555-9472 | 8294398571      | 0NTHK55       |
-- | 561160 | Kathryn | (609) 555-5876 | 6121106406      | 4ZY7I8T       |
-- | 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
-- | 907148 | Carina  | (031) 555-6622 | 9628244268      | Q12B3Z3       |
-- +--------+---------+----------------+-----------------+---------------+
-- Check the flight data since Raymond seems to have overheard the conversation
-- From Datapoints 1, 2 & 3 we can now compare and narrow the suspects using below query
select
  *
from
  people
where
  license_plate in (
    select
      license_plate
    from
      bakery_security_logs
    where
      (
        year = 2021
        and month = 7
        and day = 28
        and hour = 10
        and activity = 'exit'
        and minute <= 25
        and passport_number in (
          select
            passport_number
          from
            people
          where
            id in (
              select
                person_id
              from
                bank_accounts
              where
                account_number in (
                  select
                    account_number
                  from
                    atm_transactions
                  where
                    (
                      year = 2021
                      and month = 7
                      and day = 28
                      and atm_location = 'Leggett Street'
                      and transaction_type = 'withdraw'
                      and passport_number in (
                        select
                          passport_number
                        from
                          people
                        where
                          phone_number in (
                            select
                              caller
                            from
                              phone_calls
                            where
                              (
                                year = 2021
                                and month = 7
                                and day = 28
                                and duration <= 60
                              )
                          )
                      )
                    )
                )
            )
        )
      )
  );
-- This provides following inputs:
-- +--------+-------+----------------+-----------------+---------------+
-- |   id   | name  |  phone_number  | passport_number | license_plate |
-- +--------+-------+----------------+-----------------+---------------+
-- | 514354 | Diana | (770) 555-1861 | 3592750733      | 322W7JE       |
-- | 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       |
-- +--------+-------+----------------+-----------------+---------------+
-- Between the two, we now have to find which one is on the flight and to which city they flew.
-- From flights table, check the earliest flight scheduled to fly the next day, i.e. 2021-7-29
select
  *
from
  flights
where
  (
    year = 2021
    and month = 7
    and day = 29
    and hour = (
      select
        min(hour)
      from
        flights
      where
        (
          year = 2021
          and month = 7
          and day = 29
        )
    )
  );
-- Querying as below, we get
-- +----+-------------------+------------------------+------+-------+-----+------+--------+
-- | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
-- +----+-------------------+------------------------+------+-------+-----+------+--------+
-- | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
-- +----+-------------------+------------------------+------+-------+-----+------+--------+
-- Checking passenger list with below query, we get:
select
  *
from
  people
where
  passport_number in (
    select
      passport_number
    from
      passengers
    where
      flight_id = (
        select
          id
        from
          flights
        where
          (
            year = 2021
            and month = 7
            and day = 29
            and hour = (
              select
                min(hour)
              from
                flights
              where
                (
                  year = 2021
                  and month = 7
                  and day = 29
                )
            )
          )
      )
  );
-- +--------+--------+----------------+-----------------+---------------+
-- |   id   |  name  |  phone_number  | passport_number | license_plate |
-- +--------+--------+----------------+-----------------+---------------+
-- | 395717 | Kenny  | (826) 555-1652 | 9878712108      | 30G67EN       |
-- | 398010 | Sofia  | (130) 555-0289 | 1695452385      | G412CB7       |
-- | 449774 | Taylor | (286) 555-6063 | 1988161715      | 1106N58       |
-- | 467400 | Luca   | (389) 555-5198 | 8496433585      | 4328GD8       |
-- | 560886 | Kelsey | (499) 555-9472 | 8294398571      | 0NTHK55       |
-- | 651714 | Edward | (328) 555-1152 | 1540955065      | 130LD9Z       |
-- | 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       |
-- | 953679 | Doris  | (066) 555-9701 | 7214083635      | M51FA04       |
-- +--------+--------+----------------+-----------------+---------------+
-- Now filter the suspect table with those who are on this flight
-- This super long query yeilds the culprit
select
  *
from
  people
where
  (
    passport_number in (
      select
        passport_number
      from
        people
      where
        passport_number in (
          select
            passport_number
          from
            passengers
          where
            flight_id = (
              select
                id
              from
                flights
              where
                (
                  year = 2021
                  and month = 7
                  and day = 29
                  and hour = (
                    select
                      min(hour)
                    from
                      flights
                    where
                      (
                        year = 2021
                        and month = 7
                        and day = 29
                      )
                  )
                )
            )
        )
    )
    and license_plate in (
      select
        license_plate
      from
        bakery_security_logs
      where
        (
          year = 2021
          and month = 7
          and day = 28
          and hour = 10
          and activity = 'exit'
          and minute <= 25
          and passport_number in (
            select
              passport_number
            from
              people
            where
              id in (
                select
                  person_id
                from
                  bank_accounts
                where
                  account_number in (
                    select
                      account_number
                    from
                      atm_transactions
                    where
                      (
                        year = 2021
                        and month = 7
                        and day = 28
                        and atm_location = 'Leggett Street'
                        and transaction_type = 'withdraw'
                        and passport_number in (
                          select
                            passport_number
                          from
                            people
                          where
                            phone_number in (
                              select
                                caller
                              from
                                phone_calls
                              where
                                (
                                  year = 2021
                                  and month = 7
                                  and day = 28
                                  and duration <= 60
                                )
                            )
                        )
                      )
                  )
              )
          )
        )
    )
  );
-- And the culprit is:
-- ANSWER 1 (Who the thief is)
-- +--------+-------+----------------+-----------------+---------------+
-- |   id   | name  |  phone_number  | passport_number | license_plate |
-- +--------+-------+----------------+-----------------+---------------+
-- | 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       |
-- +--------+-------+----------------+-----------------+---------------+
-- ANSWER 2 (Which Did he escape to)
-- We know which destination id, bruce is flying
select
  destination_airport_id
from
  flights
where
  (
    year = 2021
    and month = 7
    and day = 29
    and hour = (
      select
        min(hour)
      from
        flights
      where
        (
          year = 2021
          and month = 7
          and day = 29
        )
    )
  );
-- +------------------------+
-- | destination_airport_id |
-- +------------------------+
-- | 4                      |
-- +------------------------+
-- Plugging it into the airports table, we get:
select
  *
from
  airports
where
  id = (
    select
      destination_airport_id
    from
      flights
    where
      (
        year = 2021
        and month = 7
        and day = 29
        and hour = (
          select
            min(hour)
          from
            flights
          where
            (
              year = 2021
              and month = 7
              and day = 29
            )
        )
      )
  );
-- +----+--------------+-------------------+---------------+
-- | id | abbreviation |     full_name     |     city      |
-- +----+--------------+-------------------+---------------+
-- | 4  | LGA          | LaGuardia Airport | New York City |
-- +----+--------------+-------------------+---------------+
-- ANSWER 3 (Who the thief’s accomplice is who helped them escape)
-- Plugging in Bruce's phone number into the call records on the day of theft, we get:
select
  receiver
from
  phone_calls
where
  (
    year = 2021
    and month = 7
    and day = 28
    and duration <= 60
    and caller = (
      select
        phone_number
      from
        people
      where
        (
          passport_number in (
            select
              passport_number
            from
              people
            where
              passport_number in (
                select
                  passport_number
                from
                  passengers
                where
                  flight_id = (
                    select
                      id
                    from
                      flights
                    where
                      (
                        year = 2021
                        and month = 7
                        and day = 29
                        and hour = (
                          select
                            min(hour)
                          from
                            flights
                          where
                            (
                              year = 2021
                              and month = 7
                              and day = 29
                            )
                        )
                      )
                  )
              )
          )
          and license_plate in (
            select
              license_plate
            from
              bakery_security_logs
            where
              (
                year = 2021
                and month = 7
                and day = 28
                and hour = 10
                and activity = 'exit'
                and minute <= 25
                and passport_number in (
                  select
                    passport_number
                  from
                    people
                  where
                    id in (
                      select
                        person_id
                      from
                        bank_accounts
                      where
                        account_number in (
                          select
                            account_number
                          from
                            atm_transactions
                          where
                            (
                              year = 2021
                              and month = 7
                              and day = 28
                              and atm_location = 'Leggett Street'
                              and transaction_type = 'withdraw'
                              and passport_number in (
                                select
                                  passport_number
                                from
                                  people
                                where
                                  phone_number in (
                                    select
                                      caller
                                    from
                                      phone_calls
                                    where
                                      (
                                        year = 2021
                                        and month = 7
                                        and day = 28
                                        and duration <= 60
                                      )
                                  )
                              )
                            )
                        )
                    )
                )
              )
          )
        )
    )
  );
-- +----------------+
-- |    receiver    |
-- +----------------+
-- | (375) 555-8161 |
-- +----------------+
-- Search this number in the people database and we have our accomplice
select
  *
from
  people
where
  phone_number = (
    select
      receiver
    from
      phone_calls
    where
      (
        year = 2021
        and month = 7
        and day = 28
        and duration <= 60
        and caller = (
          select
            phone_number
          from
            people
          where
            (
              passport_number in (
                select
                  passport_number
                from
                  people
                where
                  passport_number in (
                    select
                      passport_number
                    from
                      passengers
                    where
                      flight_id = (
                        select
                          id
                        from
                          flights
                        where
                          (
                            year = 2021
                            and month = 7
                            and day = 29
                            and hour = (
                              select
                                min(hour)
                              from
                                flights
                              where
                                (
                                  year = 2021
                                  and month = 7
                                  and day = 29
                                )
                            )
                          )
                      )
                  )
              )
              and license_plate in (
                select
                  license_plate
                from
                  bakery_security_logs
                where
                  (
                    year = 2021
                    and month = 7
                    and day = 28
                    and hour = 10
                    and activity = 'exit'
                    and minute <= 25
                    and passport_number in (
                      select
                        passport_number
                      from
                        people
                      where
                        id in (
                          select
                            person_id
                          from
                            bank_accounts
                          where
                            account_number in (
                              select
                                account_number
                              from
                                atm_transactions
                              where
                                (
                                  year = 2021
                                  and month = 7
                                  and day = 28
                                  and atm_location = 'Leggett Street'
                                  and transaction_type = 'withdraw'
                                  and passport_number in (
                                    select
                                      passport_number
                                    from
                                      people
                                    where
                                      phone_number in (
                                        select
                                          caller
                                        from
                                          phone_calls
                                        where
                                          (
                                            year = 2021
                                            and month = 7
                                            and day = 28
                                            and duration <= 60
                                          )
                                      )
                                  )
                                )
                            )
                        )
                    )
                  )
              )
            )
        )
      )
  );
