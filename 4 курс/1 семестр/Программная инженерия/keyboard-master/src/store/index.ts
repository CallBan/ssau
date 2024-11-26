import { configureStore, createSlice } from "@reduxjs/toolkit";
import { useDispatch, useSelector } from "react-redux";
import { type State, initialState } from "./state";

const slice = createSlice({
    initialState,
    name: "slice",
    reducers: {},
});

export const store = configureStore<State>({
    reducer: slice.reducer,
});

export const useAppDispatch = useDispatch.withTypes<typeof store.dispatch>;
export const useAppSelector = useSelector.withTypes<State>();
