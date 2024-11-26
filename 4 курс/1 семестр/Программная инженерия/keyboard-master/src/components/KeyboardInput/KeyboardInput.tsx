import { MutableRefObject, RefObject, useRef } from "react";
import {
    InvisibleInput,
    Placeholder,
    TextInputContainer,
    WrongInput,
} from "./styles";

interface Props {
    value: string;
    placeholder: string;
    onInput?: (char: string) => void;
}

export function KeyboardInput(props: Props) {
    const { value, placeholder } = props;
    const inputElement: MutableRefObject<HTMLInputElement> = useRef(null!);

    const spans = validate(value, placeholder).map((text, i) => {
        return text.good ? (
            <span>{text.text}</span>
        ) : (
            <WrongInput>{text.text}</WrongInput>
        );
    });

    const leftover = leftoverPlaceholder(value, placeholder);
    return (
        <TextInputContainer
            onClick={() => {
                console.log("clicked input");
                inputElement.current.focus();
            }}
        >
            <InvisibleInput
                ref={inputElement}
                value={value}
                onChange={(e) => {
                    props.onInput?.(e.target.value);
                }}
                onKeyDown={(e) => {
                    if (e.key === "Backspace") {
                        const target: HTMLInputElement =
                            e.target as HTMLInputElement;
                        e.preventDefault();
                    }
                }}
            />

            {spans}
            <Placeholder>{leftover}</Placeholder>
        </TextInputContainer>
    );
}

function validate(
    value: string,
    placeholder: string
): { text: string; good: boolean }[] {
    const result = [];

    const length = Math.min(value.length, placeholder.length);

    for (let i = 0; i < length; i++) {
        if (value[i] !== placeholder[i]) {
            result.push({ text: value[i], good: false });
        } else {
            result.push({ text: value[i], good: true });
        }
        // if (lookingForGood && value[i] !== placeholder[i]) {
        //     result.push(buf);
        //     buf = "";
        //     lookingForGood = false;
        // } else if (!lookingForGood && value[i] === placeholder[i]) {
        //     result.push(buf);
        //     buf = "";
        //     lookingForGood = true;
        // }
    }

    return result;
}

function leftoverPlaceholder(value: string, placeholder: string): string {
    const length = Math.min(value.length, placeholder.length);
    let buf = "";
    for (let i = length; i < placeholder.length; i++) {
        buf += placeholder[i];
    }
    return buf;
}
