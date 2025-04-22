İşte doğrudan kopyalayıp kullanabileceğin hali:

---

# Temperature Converter Project

**Emre Çubuk - 220302393**  
**Ethem Kesim - 210302205**

---

## 1. Project Purpose

The purpose of this project is to implement a temperature converter using MIPS Assembly language.  
The user selects an input temperature unit (Celsius, Fahrenheit, Kelvin, or Rankine), provides a value, and the program converts it to the remaining three units and displays them.

---

## 2. Tools Used

- MARS 4.5 (MIPS Assembler and Runtime Simulator)

---

## 3. How It Works

The program follows these steps:
1. Prompts the user to select the temperature unit.
2. Receives the temperature value; if the value is not between 1-4, the program asks the user to enter the value again.
3. Converts the input value into Celsius using the appropriate formula.
4. Converts from Celsius to the other temperature units.
5. Displays the results, excluding the originally selected unit.

---

## 4. Conversion Formulas

- **Fahrenheit to Celsius:** (F - 32) × 5 ÷ 9
- **Kelvin to Celsius:** K - 273
- **Rankine to Celsius:** (R - 491) × 5 ÷ 9
- **Celsius to Fahrenheit:** (C × 9 ÷ 5) + 32
- **Celsius to Kelvin:** C + 273
- **Celsius to Rankine:** (C + 273) × 9 ÷ 5

---

## 5. Challenges Faced

- Showing an error message for invalid numbers and repeating the menu until the user entered a valid option (between 1 and 4). This required careful control flow to prevent incorrect calculations or crashes.
- Avoiding the output of the originally selected unit required additional logic branches and checks.

---

## 6. Outcome

This project helped reinforce understanding of:
- MIPS Assembly syntax
- Syscall usage
- Arithmetic instructions
- Control flow structures

It also demonstrates how low-level programming can simulate high-level application behaviors.

---

## 7. Explanation of Code

### .data Segment — Declaring Static Strings
![image](https://github.com/user-attachments/assets/85db743b-a785-467e-b1ae-82ecfd2af6e2)

- This section defines all the fixed strings used in the program.
- **prompt**: Displays the unit selection menu.
- **enter_value**: Asks for a temperature value.
- **invalid_input**: Displayed when an invalid option is entered.
- **out_c**, **out_f**, **out_k**, **out_r**: Labels for output display.
- **newline**: Used for formatting printed lines.

---

### .text Segment and main Label — Program Entry
![image](https://github.com/user-attachments/assets/ad6f5780-75d2-4d82-be04-d15166db796a)

- Marks the beginning of executable instructions.
- `.globl main` ensures the linker recognizes `main` as the program entry point.
- `main:` is the starting label.

---

### Input Unit Selection + Validation Loop
![image](https://github.com/user-attachments/assets/bee9a2fd-87d9-4081-acac-69ee9ac24aef)

- Displays the menu using syscall 4.
- Reads the user's selection (1–4) using syscall 5 and stores it in `$t0`.
- If the input is invalid (less than 1 or greater than 4), it prints an error message and repeats the menu.
- Valid input continues to the next step.

---

### Reading the Temperature Value
![image](https://github.com/user-attachments/assets/23b8c390-6475-4082-84db-75c8cc603081)

- Prompts the user for the temperature value.
- Reads the input using syscall 5 and stores it in `$t1`.

---

### Convert Input to Celsius (Normalization)
![image](https://github.com/user-attachments/assets/1ea7aa52-103d-4e92-827d-9f4aa92b91f7)

- Based on the selected unit, the program jumps to the appropriate label to convert the input to Celsius:

#### - Celsius
![image](https://github.com/user-attachments/assets/e79abb1a-633c-4751-8ca5-d180d1c8eae5)

  - No conversion needed; passes the value directly to `$t2`.

#### - Fahrenheit to Celsius
![image](https://github.com/user-attachments/assets/166b05fc-ce76-41f4-a310-289275866715)

  - Formula: (F - 32) × 5 ÷ 9

#### - Kelvin to Celsius
![image](https://github.com/user-attachments/assets/a9bc082c-65a0-43b5-9297-9232a2fe0aef)

  - Formula: K - 273

#### - Rankine to Celsius
![image](https://github.com/user-attachments/assets/665dbff0-cc43-447a-835d-0d3babb3c871)

  - Formula: (R - 491) × 5 ÷ 9

---

### Convert Celsius to Other Units
![image](https://github.com/user-attachments/assets/4d978225-bea8-4b98-8519-7e9ccb6b9298)

- Converts Celsius to:
  - Fahrenheit: (C × 9 ÷ 5) + 32 (stored in `$t5`)
  - Kelvin: C + 273
  - Rankine: (C + 273) × 9 ÷ 5

---

### Conditionally Print Other Units
![image](https://github.com/user-attachments/assets/0b4ed420-2336-4fc2-b1f8-06319ca3bd6b)

- If the input was **not** Celsius, show the Celsius result.
- Similarly, outputs for Fahrenheit, Kelvin, and Rankine are shown, skipping the originally selected unit.

---

### Exit the Program

- Exits the program gracefully using syscall 10.

---

