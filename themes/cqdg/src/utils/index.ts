export interface IOption {
    label: string;
    value: string;
}

export interface IUserOptions {
    roleOptions: IOption[];
    researchDomainOptions: IOption[];
}

const OTHER_KEY = 'other';

/**
 * Sort alphabetically options by label name and translate
 * @param options: the array of options to sort
 * @param advancedMsg: the function to translate
 * @param messagePrefix: the prefix to add to the translation
 */
export const sortOptionsLabelsByName = (options: IOption[], advancedMsg: any, messagePrefix = '') =>
    /** sort options without other key */
    [
        ...options
            .filter((option) => option.value !== OTHER_KEY)
            .sort((a, b) => {
                const aLabel = advancedMsg(`${messagePrefix}${a.value}`);
                const bLabel = advancedMsg(`${messagePrefix}${b.value}`);
                return aLabel < bLabel ? -1 : 1;
            })
            .map((option) => ({
                value: option.value,
                label: advancedMsg(`${messagePrefix}${option.value}`) || option.label,
            })),
        ...options.filter((option) => option.value === OTHER_KEY),
    ];
