-- Chekck the available information
.schema

-- Check what the crime scene report has to say
select description from crime_scene_reports where (year=2021 and month=7 and day=28 and description like '%CS50%');
-- Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
-- Interviews were conducted today with three witnesses who were present at the time
-- each of their interview transcripts mentions the bakery.

-- Check the interview transcripts
select name, transcript from interviews where (year=2021 and month=7 and day=28 and transcript like '%bakery%');

-- (1) Ruth Says:
-- Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot
-- and drive away. If you have security footage from the bakery parking lot, you might want to look
-- for cars that left the parking lot in that time frame.

-- (2) Eugene Says
-- I don't know the thief's name, but it was someone I recognized. Earlier this morning,
-- before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there
-- withdrawing some money.

-- (3) Raymond Says
-- As the thief was leaving the bakery, they called someone who talked to them for less than a minute.
-- In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.
-- The thief then asked the person on the other end of the phone to purchase the flight ticket.

-- ACTIONS
-- (ACTION 1) Check the bakery_security_logs for number plates and trace people who left 10 min from the theft
CREATE TABLE T1 AS
select name, phone_number, passport_number, people.license_plate, people.id
from bakery_security_logs join people on bakery_security_logs.license_plate = people.license_plate
where (year=2021 and month=7 and day=28 and hour = 10 and minute < 25 and minute > 15);
select * from T1;

-- SUSPECT 1
-- +---------+----------------+-----------------+---------------+--------+
-- |  name   |  phone_number  | passport_number | license_plate |   id   |
-- +---------+----------------+-----------------+---------------+--------+
-- | Vanessa | (725) 555-4692 | 2963008352      | 5P2BI95       | 221103 |
-- | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       | 686048 |
-- | Barry   | (301) 555-4174 | 7526138472      | 6P58WS2       | 243696 |
-- | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       | 467400 |
-- | Sofia   | (130) 555-0289 | 1695452385      | G412CB7       | 398010 |
-- | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       | 396669 |
-- | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       | 514354 |
-- | Kelsey  | (499) 555-9472 | 8294398571      | 0NTHK55       | 560886 |
-- +---------+----------------+-----------------+---------------+--------+


-- (ACTION 2) Check ATM and BANK data for withdrawal
CREATE TABLE T2 AS
select name, phone_number, passport_number, people.license_plate, people.id
from atm_transactions join bank_accounts on atm_transactions.account_number = bank_accounts.account_number
join people on people.id = bank_accounts.person_id
where (year=2021 and month=7 and day=28 and atm_location = 'Leggett Street' and transaction_type = 'withdraw');
select * from T2;

-- SUSPECT 2
-- +---------+----------------+-----------------+---------------+--------+
-- |  name   |  phone_number  | passport_number | license_plate |   id   |
-- +---------+----------------+-----------------+---------------+--------+
-- | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       | 686048 |
-- | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       | 514354 |
-- | Brooke  | (122) 555-4581 | 4408372428      | QX4YZN3       | 458378 |
-- | Kenny   | (826) 555-1652 | 9878712108      | 30G67EN       | 395717 |
-- | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       | 396669 |
-- | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       | 467400 |
-- | Taylor  | (286) 555-6063 | 1988161715      | 1106N58       | 449774 |
-- | Benista | (338) 555-6650 | 9586786673      | 8X428L0       | 438727 |
-- +---------+----------------+-----------------+---------------+--------+


-- (ACTION 3) Check Calling Data
CREATE TABLE T3 AS
select name, phone_number, passport_number, people.license_plate, people.id
from phone_calls join people on phone_calls.caller = people.phone_number
where (year=2021 and month=7 and day=28 and duration < 60);
select * from T3;

-- +---------+----------------+-----------------+---------------+--------+
-- |  name   |  phone_number  | passport_number | license_plate |   id   |
-- +---------+----------------+-----------------+---------------+--------+
-- | Sofia   | (130) 555-0289 | 1695452385      | G412CB7       | 398010 |
-- | Kelsey  | (499) 555-9472 | 8294398571      | 0NTHK55       | 560886 |
-- | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       | 686048 |
-- | Kelsey  | (499) 555-9472 | 8294398571      | 0NTHK55       | 560886 |
-- | Taylor  | (286) 555-6063 | 1988161715      | 1106N58       | 449774 |
-- | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       | 514354 |
-- | Carina  | (031) 555-6622 | 9628244268      | Q12B3Z3       | 907148 |
-- | Kenny   | (826) 555-1652 | 9878712108      | 30G67EN       | 395717 |
-- | Benista | (338) 555-6650 | 9586786673      | 8X428L0       | 438727 |
-- +---------+----------------+-----------------+---------------+--------+


-- Merge the suspect list from 1, 2 and 3 to narrow down
CREATE TABLE S1 AS
select T1.name, T1.phone_number, T1.passport_number, T1.license_plate, T1.id from T1 join T2 on T1.id = T2.id join T3 on T2.id = T3.id;

-- We now get the shortened list as under:
-- +-------+----------------+-----------------+---------------+--------+
-- | name  |  phone_number  | passport_number | license_plate |   id   |
-- +-------+----------------+-----------------+---------------+--------+
-- | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       | 686048 |
-- | Diana | (770) 555-1861 | 3592750733      | 322W7JE       | 514354 |
-- +-------+----------------+-----------------+---------------+--------+

-- Look at the flight data to check passengers on morning flight
CREATE TABLE T4 AS
select name, phone_number, people.passport_number, people.license_plate, people.id
from flights join passengers on flights.id = passengers.flight_id
join people on people.passport_number = passengers.passport_number
where (year=2021 and month=7 and day=29 and
hour = (select min(hour) from flights where (year=2021 and month=7 and day=29)));
select * from T4;

-- The ones taking the morning flight are:
-- +--------+----------------+-----------------+---------------+--------+
-- |  name  |  phone_number  | passport_number | license_plate |   id   |
-- +--------+----------------+-----------------+---------------+--------+
-- | Doris  | (066) 555-9701 | 7214083635      | M51FA04       | 953679 |
-- | Sofia  | (130) 555-0289 | 1695452385      | G412CB7       | 398010 |
-- | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       | 686048 |
-- | Edward | (328) 555-1152 | 1540955065      | 130LD9Z       | 651714 |
-- | Kelsey | (499) 555-9472 | 8294398571      | 0NTHK55       | 560886 |
-- | Taylor | (286) 555-6063 | 1988161715      | 1106N58       | 449774 |
-- | Kenny  | (826) 555-1652 | 9878712108      | 30G67EN       | 395717 |
-- | Luca   | (389) 555-5198 | 8496433585      | 4328GD8       | 467400 |
-- +--------+----------------+-----------------+---------------+--------+

-- Filter the above list to get our suspect list
CREATE TABLE S2 AS
select * from T4 where T4.passport_number in (select passport_number from S1);
select * from S2;

-- And we have our culprit
-- +-------+----------------+-----------------+---------------+--------+
-- | name  |  phone_number  | passport_number | license_plate |   id   |
-- +-------+----------------+-----------------+---------------+--------+
-- | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       | 686048 |
-- +-------+----------------+-----------------+---------------+--------+

-- Where did he fly?
CREATE TABLE S3 AS
select S2.name, city, phone_number from flights join passengers on flights.id = passengers.flight_id join S2 on S2.passport_number = passengers.passport_number join airports on flights.destination_airport_id = airports.id;
select * from S3;
-- +-------+---------------+----------------+
-- | name  |     city      |  phone_number  |
-- +-------+---------------+----------------+
-- | Bruce | New York City | (367) 555-5533 |
-- +-------+---------------+----------------+

-- Who was the accomplice ?
select people.name from phone_calls join S3 on S3.phone_number = phone_calls.caller join people on people.phone_number = phone_calls.receiver
where (year=2021 and month=7 and day=28 and duration < 60);
-- +-------+
-- | name  |
-- +-------+
-- | Robin |
-- +-------+


DROP TABLE T1;
DROP TABLE T2;
DROP TABLE T3;
DROP TABLE T4;
DROP TABLE S1;
DROP TABLE S2;
DROP TABLE S3;
