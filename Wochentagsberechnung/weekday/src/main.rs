extern crate chrono;
use chrono::{NaiveDate,Datelike,Weekday};
use std::convert::TryFrom;
use std::ops::Rem;

fn weekday(date: NaiveDate) -> Result<(), ()>
{
    const CORRECTION: [u32; 12] = [0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5];

    let year = u32::try_from(date.year()).unwrap();
    let leapyear: bool = match (year % 100, year % 400, year % 4) {
        (0, 0, 0) => true, // every 400 years the full hundreds are a leap year
        (0, _, 0) => false, // normal hundreds are not leap years
        (_, _, 0) => true, // every fourth year is a leap year, too
        (_, _, _) => false,
    };

    let month_correct = match date.month0() {
        0..=11 => CORRECTION[usize::try_from(date.month0()).unwrap()],
        _ => return Err(()),
    };
    println!("Parsed as: {}", date.format("%Y-%m-%d").to_string());
    println!("Leap year: {}", &leapyear);

    let remainder_y: u32 = year.rem(100);
    let leap_days: u32 = remainder_y / 4;
    println!("Remainder for year: {}", &remainder_y);
    println!("Leap days within current century: {}", &leap_days);

    // TODO: correct for the century ...
    let weekday = (leap_days + remainder_y + month_correct + date.day()) % 7;
    println!("Weekday (ours  ): {}", &weekday);
    println!("Weekday (chrono): {} ({})", date.weekday().num_days_from_sunday(), date.weekday());
    
    Ok(())
}

fn app_logic() -> Result<(), ()>
{
    let date = match std::env::args().nth(1) {
        Some(date) => date,
        None => {
            eprintln!("Error: no date given (expecting YYYY-mm-dd (%Y-%m-%d) format)");
            return Err(());
        }
    };

    let date = match NaiveDate::parse_from_str(&date, "%Y-%m-%d") {
        Ok(date) => date,
        Err(error) =>
        {
            eprintln!("Error: given string \"{}\" could not be parsed as YYYY-mm-dd (%Y-%m-%d). {:?}.", date, error);
            return Err(());
        }
    };

    weekday(date)
}

fn main()
{
    std::process::exit(match app_logic() {
        Ok(_) => 0,
        Err(_) =>
        {
            eprintln!("Something went wrong.");
            1
        }
    });
}

// https://en.wikipedia.org/wiki/Determination_of_the_day_of_the_week

#[cfg(test)]
mod tests
{
    use super::*;

    const DATES: [&str; 6] = ["1815-12-10", "1878-11-07", "1900-01-01", "1917-05-29", "1963-11-22", "1968-10-27"];
// 1815-12-10 -> Sunday
// 1878-11-07 -> Thursday
// 1900-01-01 -> Monday
// 1917-05-29 -> Tuesday
// 1963-11-22 -> Friday
// 1968-10-27 -> Sunday

    #[test]
    fn test_known_dates()
    {
        for date in DATES
        {
            let date = match NaiveDate::parse_from_str(&date, "%Y-%m-%d")
            {
                Ok(date) => date,
                Err(error) => NaiveDate::from_ymd(1, 1, 1)
            };
            assert_ne!(date.year(), 1);
        }
// 1815-12-10 -> Sunday
// 1878-11-07 -> Thursday
// 1900-01-01 -> Monday
// 1917-05-29 -> Tuesday
// 1963-11-22 -> Friday
// 1968-10-27 -> Sunday
    }
}
