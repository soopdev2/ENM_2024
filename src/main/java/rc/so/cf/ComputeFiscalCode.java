package rc.so.cf;

import static rc.so.cf.FunctionChecks.howManyConsonants;
import static rc.so.cf.FunctionChecks.isAllLetters;
import static rc.so.cf.FunctionChecks.isDateValid;
import static rc.so.cf.FunctionChecks.isYearValid;
import static rc.so.cf.FunctionChecks.replaceSpecialChars;
import static rc.so.cf.NameAndSurnameComputations.pickFirstConsonantAndFirstTwoVowels;
import static rc.so.cf.NameAndSurnameComputations.pickFirstThirdAndFourthConsonant;
import static rc.so.cf.NameAndSurnameComputations.pickFirstThreeConsonants;
import static rc.so.cf.NameAndSurnameComputations.pickFirstThreeVowels;
import static rc.so.cf.NameAndSurnameComputations.pickFirstTwoConsonantsAndFirstVowel;
import static rc.so.db.Action.insertTR;
import static rc.so.util.Utility.estraiEccezione;
import javax.swing.*;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;



public class ComputeFiscalCode {

    public static String computeSurname(String input) {
        String error = "0";
        input = replaceSpecialChars(input);

        if (isAllLetters(input)) {
            StringBuilder result = new StringBuilder();
            input = input.toUpperCase();

            if (input.length() < 3) {
                result = new StringBuilder(input);
                while (result.length() < 3) {
                    result.append("X");
                }
            } else {
                switch (howManyConsonants(input)) {
                    case 0:
                        result.append(pickFirstThreeVowels(input));
                        break;
                    case 1:
                        result.append(pickFirstConsonantAndFirstTwoVowels(input));
                        break;
                    case 2:
                        result.append(pickFirstTwoConsonantsAndFirstVowel(input));
                        break;
                    default:
                        result.append(pickFirstThreeConsonants(input));
                }
            }
            return result.toString();
        } else {
            JOptionPane.showMessageDialog(
                    null,
                    "Please insert a valid input in \"Surname\" field.",
                    "Error",
                    JOptionPane.WARNING_MESSAGE);
            return error;
        }
    }

    public static String computeName(String inputName) {
        String error = "0";
        inputName = replaceSpecialChars(inputName);
        if (isAllLetters(inputName)) {
            StringBuilder result = new StringBuilder();
            inputName = inputName.toUpperCase();

            if (inputName.length() < 3) {
                result = new StringBuilder(inputName);
                while (result.length() < 3)
                    result.append("X");
            } else {
                switch (howManyConsonants(inputName)) {
                    case 0:
                        result.append(pickFirstThreeVowels(inputName));
                        break;
                    case 1:
                        result.append(pickFirstConsonantAndFirstTwoVowels(inputName));
                        break;
                    case 2:
                        result.append(pickFirstTwoConsonantsAndFirstVowel(inputName));
                        break;
                    case 3:
                        result.append(pickFirstThreeConsonants(inputName));
                        break;
                    default:
                        result.append(pickFirstThirdAndFourthConsonant(inputName));
                }
            }
            return result.toString();

        } else {
            JOptionPane.showMessageDialog(
                    null,
                    "Please insert a valid input in \"Name\" field.",
                    "Error",
                    JOptionPane.WARNING_MESSAGE);
            return error;
        }
    }

    public static String computeDateOfBirth(String dayString, String monthString, String yearString, String gender) {
        String yearError = "0", dateError = "0";

        if (isYearValid(yearString)) {
            if (isDateValid(dayString, monthString, yearString)) {
                String result = "";
                try {
                    int day = Integer.parseInt(dayString);
                    int month = Integer.parseInt(monthString);
                    int year = Integer.parseInt(yearString);

                    // get the last 2 digits of the year
                    if (year % 100 >= 10) {
                        result += (year % 100);
                    } else {
                        result = result + 0 + (year % 100);
                    }

                    // get the letter corresponding to the month
                    switch (month) {
                        case 1: {
                            result += "A";
                            break;
                        }
                        case 2: {
                            result += "B";
                            break;
                        }
                        case 3: {
                            result += "C";
                            break;
                        }
                        case 4: {
                            result += "D";
                            break;
                        }
                        case 5: {
                            result += "E";
                            break;
                        }
                        case 6: {
                            result += "H";
                            break;
                        }
                        case 7: {
                            result += "L";
                            break;
                        }
                        case 8: {
                            result += "M";
                            break;
                        }
                        case 9: {
                            result += "P";
                            break;
                        }
                        case 10: {
                            result += "R";
                            break;
                        }
                        case 11: {
                            result += "S";
                            break;
                        }
                        case 12: {
                            result += "T";
                            break;
                        }
                    }
                    switch (gender) {
                        case "f": {
                            result += (day + 40);
                            break;
                        }
                        case "m": {
                            result += (day <= 10 ? "0" + day : day);
                            break;
                        }
                    }
                } catch (Exception ex) {
                    insertTR("E", "SERVICE", estraiEccezione(ex));
                }
                return result;
            } else {
                JOptionPane.showMessageDialog(null, "Invalid date", "Error", JOptionPane.WARNING_MESSAGE);
                return dateError;
            }
        } else {
            String message =
                    "Please insert a numeric value between 1900 and "
                            + Calendar.getInstance().get(Calendar.YEAR)
                            + " in \"Year\" field.";
            JOptionPane.showMessageDialog(null, message, "Error", JOptionPane.WARNING_MESSAGE);
            return yearError;
        }
    }

    
    public static String computeControlChar(String incompleteFiscalCode) throws InterruptedException {
        String control = "";
        int evenSum = 0, oddSum = 0;
        incompleteFiscalCode = incompleteFiscalCode.toUpperCase();
        if (incompleteFiscalCode.length() == 15) {
            OddThread ot = new OddThread(incompleteFiscalCode, oddSum);
            Thread t1 = new Thread(ot);
            t1.start();
            t1.join();
            oddSum = ot.getOddSum();

            EvenThread et = new EvenThread(incompleteFiscalCode, evenSum);
            Thread t2 = new Thread(et);
            t2.start();
            t2.join();
            evenSum = et.getEvenSum();

            // The remainder of the division is the control character
            int sum = (oddSum + evenSum) % 26;
            switch (sum) {
                case 0: {
                    control = "A";
                    break;
                }
                case 1: {
                    control = "B";
                    break;
                }
                case 2: {
                    control = "C";
                    break;
                }
                case 3: {
                    control = "D";
                    break;
                }
                case 4: {
                    control = "E";
                    break;
                }
                case 5: {
                    control = "F";
                    break;
                }
                case 6: {
                    control = "G";
                    break;
                }
                case 7: {
                    control = "H";
                    break;
                }
                case 8: {
                    control = "I";
                    break;
                }
                case 9: {
                    control = "J";
                    break;
                }
                case 10: {
                    control = "K";
                    break;
                }
                case 11: {
                    control = "L";
                    break;
                }
                case 12: {
                    control = "M";
                    break;
                }
                case 13: {
                    control = "N";
                    break;
                }
                case 14: {
                    control = "O";
                    break;
                }
                case 15: {
                    control = "P";
                    break;
                }
                case 16: {
                    control = "Q";
                    break;
                }
                case 17: {
                    control = "R";
                    break;
                }
                case 18: {
                    control = "S";
                    break;
                }
                case 19: {
                    control = "T";
                    break;
                }
                case 20: {
                    control = "U";
                    break;
                }
                case 21: {
                    control = "V";
                    break;
                }
                case 22: {
                    control = "W";
                    break;
                }
                case 23: {
                    control = "X";
                    break;
                }
                case 24: {
                    control = "Y";
                    break;
                }
                case 25: {
                    control = "Z";
                    break;
                }
            }
        }
        return control;
    }
}
