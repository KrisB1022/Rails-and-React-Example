import React from 'react';
import { shallow } from 'enzyme';

import Sitters from '../../../components/sitters/index';
import Sitter from '../../../components/sitters/Sitter';

test('should render without crashing', () => {
    shallow(
        <Sitters sitters={[]} />
    );
});

test('should have correct container markup', () => {
    const component = shallow( 
        <Sitters sitters={[]} />
    );
    
    expect(component.find('.sittersWrapper').exists()).toBeTruthy();
    expect(component.find('.sittersWrapper').length).toBe(1);
});

test('should render correct amount of <Sitter />', () => {
    const sitter = {
        attributes: {
            image: 'image.jpg',
            name: 'Joseph',
            ratingsScore: 5
        }
    }
    const sitters = [
        { id: '1', ...sitter }, 
        { id: '2', ...sitter },
        { id: '3', ...sitter }
    ];

    const component = shallow(
        <Sitters sitters={sitters} />
    );

    expect(component.find(Sitter).exists()).toBeTruthy();
    expect(component.find(Sitter).length).toBe(3);
});

