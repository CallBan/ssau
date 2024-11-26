import { useState } from "react";
import { KeyboardInput } from "../components/KeyboardInput";

interface Props {}

export function KeyboardInputTest(props: Props) {
    const [value, setValue] = useState("");

    const exampleText =
        "Восемьдесят три процента всех дней в году начинаются одинаково: звенит будильник";
    return (
        <>
            <KeyboardInput
                value={value}
                placeholder={exampleText}
                onInput={(char) => {
                    setValue((val) => char);
                }}
            />
            <button onClick={() => setValue("")}>reset</button>
        </>
    );
}
