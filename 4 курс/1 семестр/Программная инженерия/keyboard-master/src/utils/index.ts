/**
 * Object.keys may return additional keys
 *
 * safe to use if `T` is not a supertype
 *
 * safe alternative - declare an array with all keys of T and iterate over them
 *
 * TODO: add typia to check for exact keys
 */
export function unsafeKeys<T extends object>(object: T): (keyof T)[] {
    return Object.keys(object) as (keyof T)[];
}
