import { createBrowserRouter, NavLink } from "react-router-dom";
import { KeyboardInput } from "../components/KeyboardInput";
import { KeyboardInputTest } from "../pages/KeyboardInputTest";

export const mainRouter = createBrowserRouter([
    {
        path: "/",
        element: (
            <div>
                <NavLink to="/keyboard">Keyboard</NavLink>
            </div>
        ),
    },
    {
        path: "/keyboard",
        element: <KeyboardInputTest />,
    },
]);
