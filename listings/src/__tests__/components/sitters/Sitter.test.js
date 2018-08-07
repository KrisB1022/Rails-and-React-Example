import React from 'react';
import { shallow } from 'enzyme';

import Sitter from '../../../components/sitters/Sitter';

const sitter = {
    image: 'image.jpg',
    name: 'Joseph',
    ratingsScore: 5
};

test('should render without crashing', () => {
    shallow(
        <Sitter {...sitter} />
    );
});

test('should have correct markup', () => {
    const component = shallow( 
        <Sitter {...sitter} />
    );
    
    expect(component.find('.sitter').exists()).toBeTruthy();
    expect(component.find('.sitter').length).toBe(1);

    expect(component.find('.sitterHeadshot').length).toBe(1);
    expect(component.find('.name').length).toBe(1);
    expect(component.find('.rating').length).toBe(1);
});
