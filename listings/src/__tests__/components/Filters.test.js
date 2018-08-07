import React from 'react';
import { shallow } from 'enzyme';

import Filters from '../../components/Filters';

let component;
const filterByProperty = jest.fn();

beforeEach(() => {
    component = shallow(
        <Filters
            filterByProperty={filterByProperty} 
        />
    );

    filterByProperty.mockReset();
})

test('should render without crashing', () => {
    shallow(
        <Filters
            filterByProperty={jest.fn()} 
        />
    );
});

test('should have label', () => {
    expect(component.find('label').exists()).toBeTruthy();
    expect(component.find('label').length).toBe(1);
});

test('should have select input', () => {
    expect(component.find('select').exists()).toBeTruthy();
    expect(component.find('select').length).toBe(1);
});

test('should have correct number of select options', () => {
    expect(component.find('option').exists()).toBeTruthy();
    expect(component.find('option').length).toBe(5);
});

test('should call filterByProperty onChange', () => {
    const event = {
        target: { value: 1 }
    };
    
    expect(component.find('select').exists()).toBeTruthy();

    component.find('select').simulate('change', event);
    expect(filterByProperty).toHaveBeenCalled();
});
